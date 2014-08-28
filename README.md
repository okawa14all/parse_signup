parse_signup
===================

# Setup

## 1. Set up your Parse app.

## 2. Set up a Twitter/Facebook app.

## 3. Configure facebook, twitter and parse appID

Rakefile:

```
FB_APP_ID = '<your facebook app id>'
```

app_delegate.rb:

```
def configure_parse_service(launchOptions)
  Parse.setApplicationId(
    "your parse app id",
    clientKey:"your parse clientKey"
  )
  PFFacebookUtils.initializeFacebook

  PFTwitterUtils.initializeWithConsumerKey(
    "your api key",
    consumerSecret: "your api secret")
end
```

## 4. Install gems and cocoapods

```
$ bundle install
$ rake pod:install
```

## 5. Change your Parse.h file to fix invalid bridgesupport
see [https://github.com/HipByte/motion-cocoapods/issues/93](https://github.com/HipByte/motion-cocoapods/issues/93)

# Build and Run app

```
$ rake
```
