# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'
require 'bundler'
Bundler.require

require 'bubble-wrap/core'

Motion::Project::App.setup do |app|

  app.name = 'parse_signup'
  app.identifier = 'com.your_domain_here.parse_signup'
  app.short_version = '0.1.0'
  app.version = app.short_version

  app.deployment_target = '7.0'
  # Or for iOS 6
  #app.deployment_target = '6.0'

  app.icons = ["icon@2x.png", "icon-29@2x.png", "icon-40@2x.png", "icon-60@2x.png", "icon-76@2x.png", "icon-512@2x.png"]

  # prerendered_icon is only needed in iOS 6
  #app.prerendered_icon = true

  # app.device_family = [:iphone, :ipad]
  app.device_family = [:iphone]
  app.interface_orientations = [:portrait]

  app.files += Dir.glob(File.join(app.project_dir, 'lib/**/*.rb'))

  # Use `rake config' to see complete project settings, here are some examples:
  #
  # app.fonts = ['Oswald-Regular.ttf', 'FontAwesome.otf'] # These go in /resources
  # app.frameworks += %w(QuartzCore CoreGraphics MediaPlayer MessageUI CoreData)

  app.frameworks += [
    'Accounts',
    'AudioToolbox',
    'CFNetwork',
    'CoreGraphics',
    'CoreLocation',
    'MobileCoreServices',
    'QuartzCore',
    'Security',
    'Social',
    'StoreKit',
    'SystemConfiguration']

  app.libs += [
    '/usr/lib/libz.dylib',
    '/usr/lib/libsqlite3.dylib']

  app.pods do
    pod 'SIAlertView'
    pod 'AFNetworking'
    pod 'SVProgressHUD'
    # pod 'JMImageCache'
    pod 'Parse-iOS-SDK'
  end

  FB_APP_ID = 'your facebook app id'
  app.info_plist['FacebookAppID'] = FB_APP_ID
  app.info_plist['CFBundleURLTypes'] = [{ CFBundleURLSchemes: ["fb#{FB_APP_ID}"] }]
end
