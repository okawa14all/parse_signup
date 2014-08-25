class MainController < UIViewController

  def viewDidLoad
    super

    # Sets a top of 0 to be below the navigation control, it's best not to do this
    self.edgesForExtendedLayout = UIRectEdgeNone

    rmq.stylesheet = MainStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    rmq.append(UILabel, :name).get.text = PFUser.currentUser['name']
    rmq.append(UILabel, :email).get.text = PFUser.currentUser.email

    rmq.append(UIButton, :logout_button).on(:touch) do |sender|
      logout
    end
  end

  def init_nav
    self.title = PFUser.currentUser['name']
  end

  def logout
    puts 'logout'
    PFUser.logOut
    open_walkthrough
  end

  def open_walkthrough
    w = rmq.window
    w.alpha = 0.0
    w.rootViewController =
      UINavigationController.alloc.initWithRootViewController(WalkthroughController.new)
    w.alpha = 1.0
  end
end
