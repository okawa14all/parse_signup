parse_signup
===================

Configure facebook and parse appID

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
end
```

Run

```
$ bundle install
$ rake pod:install
$ rake
```
