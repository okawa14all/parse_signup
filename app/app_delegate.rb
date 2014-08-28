class AppDelegate
  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.configure_parse_service(launchOptions)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    if PFUser.currentUser
      puts 'open_main'
      open_main
    else
      puts 'open_walkthrough'
      open_walkthrough
    end

    @window.makeKeyAndVisible
    true
  end

  def application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, withSession:PFFacebookUtils.session)
  end

  def applicationDidBecomeActive(application)
    FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session)
  end

  def configure_parse_service(launchOptions)
    Parse.setApplicationId(
      "your parse app id",
      clientKey:"your parse clientKey")

    PFFacebookUtils.initializeFacebook

    PFTwitterUtils.initializeWithConsumerKey(
      "your api key",
      consumerSecret: "your api secret")
  end

  def open_main
    @window.rootViewController = MainController.new
  end

  def open_walkthrough
    @window.rootViewController =
      UINavigationController.alloc.initWithRootViewController(WalkthroughController.new)
  end
end
