# sms_center

The `sms_center` gem. A ruby interface to use SMS platform.\
Support: Twilio, Nexmo, Telerivet, Infobip
Require: Ruby >= 2.5.0, HttpClient

## Installation

```
gem install sms_center
```
Add file sms_center.rb to /config/initializers, example below:
```
SmsCenter.configure do |config|
  config.platform_by_country = {
    th: 'Infobip',
    id: 'Twilio',
    ph: 'Telerivet',
    vn: 'Twilio',
    default: 'Nexmo'
  }

  config.root_number_by_platform = {
    Nexmo: ENV['NEXMO_ROOT_NUMBER'],
    Twilio: ENV['TWILIO_ROOT_NUMBER']
  }

  config.keys = {
      # Keys for Telerivet
      TELERIVET_API_KEY: ENV['TELERIVET_API_KEY'],
      TELERIVET_PROJECT_ID: ENV['TELERIVET_PROJECT_ID'],
      # Key for Infobip
      INFOBIP_API_KEY:  ENV['INFOBIP_API_KEY'],
      #Keys for Nexmo
      NEXMO_API_KEY: ENV['NEXMO_API_KEY'],
      NEXMO_API_SECRET: ENV['NEXMO_API_SECRET'],
      # Keys for twilio
      TWILIO_ACCOUNT_SID: ENV['TWILIO_ACCOUNT_SID'],
      TWILIO_AUTH_TOKEN: ENV['TWILIO_AUTH_TOKEN'],
      TWILIO_FROM: ENV['TWILIO_FROM']
  }
end

```

## Using
* options = {contry: 'th'} || {platform: 'Nexmo'}
* SmsCenter.new(content, to_number, options).send
