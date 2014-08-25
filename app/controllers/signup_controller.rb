class SignupController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = SignupControllerStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    @name = rmq.append(UITextField, :name).get
    name_left_padding = rmq.append(UIView, :text_field_padding).get
    @name.leftView = name_left_padding

    @email = rmq.append(UITextField, :email).get
    email_left_padding = rmq.append(UIView, :text_field_padding).get
    @email.leftView = email_left_padding

    @password = rmq.append(UITextField, :password).get
    password_left_padding = rmq.append(UIView, :text_field_padding).get
    @password.leftView = password_left_padding

    rmq.append(UIButton, :submit_button).on(:touch) do |sender|
      signup
    end
  end

  def init_nav
    self.title = 'Signup'
  end

  def signup
    unless rmq.validation.valid?(@name.text, :length, min_length: 1, max_length: 30)
      SimpleSI.alert(
        message: 'invalid name',
        transition: 'drop_down'
      )
      return
    end

    unless rmq.validation.valid?(@email.text, :email)
      SimpleSI.alert(
        message: 'invalid email',
        transition: 'drop_down')
      return
    end

    unless rmq.validation.valid?(@password.text, :length, exact_length: 9..30)
      SimpleSI.alert(
        message: 'invalid password',
        transition: 'drop_down')
      return
    end

    SVProgressHUD.showWithMaskType(SVProgressHUDMaskTypeGradient)

    user = PFUser.user
    # Parse checks username is unique or not.
    # If we want to allow duplicating username, and ensure uniquness of email,
    # we should fill email in the username property
    user.username = @email.text
    user.email = @email.text
    user.password = @password.text
    # other fields can be set just like with PFObject
    user['name'] = @name.text

    user.signUpInBackgroundWithBlock(
      lambda do |succeeded, error|
        SVProgressHUD.dismiss
        if !error
          puts 'signup success!'
          open_main
        else
          errorString = error.userInfo["error"]
          SimpleSI.alert(
            message: errorString,
            transition: 'drop_down')
        end
      end
    )
  end

  def open_main
    w = rmq.window
    w.alpha = 0.0
    w.rootViewController = MainController.new
    w.alpha = 1.0
  end

end
