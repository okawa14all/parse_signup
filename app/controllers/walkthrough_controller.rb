class WalkthroughController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = WalkthroughControllerStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    rmq.append(UILabel, :welcome)

    rmq.append(UIButton, :signup).on(:touch) do |sender|
      show_signup_methods
    end

    rmq.append(UIButton, :login).on(:touch) do |sender|
      show_login_methods
    end

    rmq.append(UIView, :btn_divider)
  end

  def init_nav
    self.title = 'Welcome'
    # self.navigationItem.tap do |nav|
    #   nav.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAction,
    #                                                                        target: self, action: :nav_left_button)
    #   nav.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh,
    #                                                                        target: self, action: :nav_right_button)
    # end
  end

  def show_signup_methods
    rmq.wrap(rmq.app.window).tap do |o|
      o.append(UIView, :overlay).animations.fade_in
      o.append(UILabel, :overlay_label).get.text = 'Sign Up'

      o.append(UIButton, :signup_with_facebook_button).on(:touch) do |sender|
        signup_or_login_with_facebook
      end

      o.append(UIButton, :signup_with_twitter_button).on(:touch) do |sender|
        signup_or_login_with_twitter
      end

      o.append(UIButton, :signup_with_email_button).on(:touch) do |sender|
        o.find(
          sender, :overlay, :overlay_label, :signup_with_facebook_button,
          :signup_with_twitter_button, :cancel_button
        ).hide.remove
        open_signup
      end

      o.append(UIButton, :cancel_button).on(:touch) do |sender|
        o.find(
          sender, :overlay, :overlay_label, :signup_with_facebook_button,
          :signup_with_twitter_button, :signup_with_email_button
        ).hide.remove
      end
    end
  end

  def show_login_methods
    rmq.wrap(rmq.app.window).tap do |o|
      o.append(UIView, :overlay).animations.fade_in
      o.append(UILabel, :overlay_label).get.text = 'Log In'

      o.append(UIButton, :login_with_facebook_button).on(:touch) do |sender|
        signup_or_login_with_facebook
      end

      o.append(UIButton, :login_with_twitter_button).on(:touch) do |sender|
        signup_or_login_with_twitter
      end

      o.append(UIButton, :login_with_email_button).on(:touch) do |sender|
        o.find(
          sender, :overlay, :overlay_label, :login_with_facebook_button,
          :login_with_twitter_button, :cancel_button
        ).hide.remove
        open_login
      end

      o.append(UIButton, :cancel_button).on(:touch) do |sender|
        o.find(
          sender, :overlay, :overlay_label, :login_with_facebook_button,
          :login_with_twitter_button, :login_with_email_button
        ).hide.remove
      end
    end
  end

  def open_signup
    controller = SignupController.new
    self.navigationController.pushViewController controller, animated: true
  end

  def open_login
    controller = LoginController.new
    self.navigationController.pushViewController controller, animated: true
  end

  def signup_or_login_with_facebook
    SVProgressHUD.showWithMaskType(SVProgressHUDMaskTypeGradient)

    PFFacebookUtils.logInWithPermissions(nil,
      block: lambda do |user, error|
        if !user
          SVProgressHUD.dismiss
          if !error
            puts 'user cancelled the Facebook login'
          else
            puts 'facebook login failed!'
            errorString = error.userInfo["error"]
            SimpleSI.alert(
              message: errorString,
              transition: 'drop_down')
          end
        elsif user.isNew
          puts 'User signed up and logged in through Facebook!'
          handle_fb_login_user
        else
          puts 'User logged in through Facebook!'
          handle_fb_login_user
        end
      end
    )
  end

  def handle_fb_login_user
    request = FBRequest.requestForMe
    request.startWithCompletionHandler(
      lambda do |connection, result, error|
        SVProgressHUD.dismiss
        if !error
          name = result['name']
          puts "Facebook user name is #{name}"
          user = PFUser.currentUser
          user['name'] = name
          user.save # maybe saveInBackgroundWithBlock is better
          open_main
        else
          puts error.userInfo["error"]
        end
      end
    )
  end

  def signup_or_login_with_twitter
    SVProgressHUD.showWithMaskType(SVProgressHUDMaskTypeGradient)

    PFTwitterUtils.logInWithBlock(
      lambda do |user, error|
        if !user
          SVProgressHUD.dismiss
          if !error
            puts 'user cancelled the Twitter login'
          else
            puts 'Twitter login failed!'
            errorString = error.userInfo["error"]
            SimpleSI.alert(
              message: errorString,
              transition: 'drop_down')
          end
        elsif user.isNew
          puts 'User signed up and logged in through Twitter!'
          handle_tw_login_user
        else
          puts 'User logged in through Twitter!'
          handle_tw_login_user
        end
      end
    )
  end

  def handle_tw_login_user
    # TODO: use better http client like AFHTTPSessionManager (> iOS7)
    #       or use twitter sdk
    url = NSURL.URLWithString("https://api.twitter.com/1.1/account/verify_credentials.json")
    request = NSMutableURLRequest.requestWithURL(url)
    PFTwitterUtils.twitter.signRequest(request)
    response = nil
    error = nil
    data = NSURLConnection.sendSynchronousRequest(request,
      returningResponse: response,
      error: error
    )
    SVProgressHUD.dismiss
    if data
      json = BubbleWrap::JSON.parse(data)
      if json['errors']
        puts json['errors']['message']
      else
        name = json['screen_name']
        puts "Twitter screen_name is #{name}"
        user = PFUser.currentUser
        user['name'] = name
        user.save # maybe saveInBackgroundWithBlock is better
        open_main
      end
    else
      puts 'Cloud not recieve data from twitter'
    end
  end

  def open_main
    w = rmq.window
    w.alpha = 0.0
    w.rootViewController = MainController.new
    w.alpha = 1.0
  end
end
