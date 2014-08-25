class LoginController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = LoginControllerStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    @email = rmq.append(UITextField, :email).get
    email_left_padding = rmq.append(UIView, :text_field_padding).get
    @email.leftView = email_left_padding

    @password = rmq.append(UITextField, :password).get
    password_left_padding = rmq.append(UIView, :text_field_padding).get
    @password.leftView = password_left_padding

    rmq.append(UIButton, :submit_button).on(:touch) do |sender|
      login
    end
  end

  def init_nav
    self.title = 'Log In'
  end

  def login
    unless rmq.validation.valid?(@email.text, :email)
      SimpleSI.alert(
        message: 'invalid email',
        transition: 'drop_down')
      return
    end

    unless rmq.validation.valid?(@password.text, :presence)
      SimpleSI.alert(
        message: 'invalid password',
        transition: 'drop_down')
      return
    end

    SVProgressHUD.showWithMaskType(SVProgressHUDMaskTypeGradient)

    PFUser.logInWithUsernameInBackground(@email.text, password: @password.text,
      block: lambda do |user, error|
        SVProgressHUD.dismiss
        if user
          puts 'login success!'
          open_main
        else
          puts 'login failed!'
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
