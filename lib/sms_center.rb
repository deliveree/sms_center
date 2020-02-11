class SmsCenter
  autoload :Infobip, 'sms_center/infobip'
  autoload :Nexmo, 'sms_center/nexmo'
  autoload :Twilio, 'sms_center/twilio'
  autoload :Telerivet, 'sms_center/telerivet'

  @@platforms = nil
  @@platform_by_country = nil
  @@keys = nil

  def self.configure
    yield self
  end

  def self.platform_by_country=(platform_by_country)
    @@platform_by_country = platform_by_country
  end

  def self.root_number_by_platform=(root_number_by_platform)
    @@root_number_by_platform = root_number_by_platform
  end

  def self.keys=(keys)
    @@keys = keys
  end

  def self.platform_by_country
    @@platform_by_country
  end

  def self.keys
    @@keys
  end

  def self.root_number_by_platform
    @@root_number_by_platform
  end

  def initialize(content, to_number, country, platform = nil)
    platform_by_country = SmsCenter.platform_by_country
    platform = platform_by_country[country.downcase.to_sym] || platform_by_country[:default] unless platform 
    from_number = SmsCenter.root_number_by_platform[platform.to_sym]
    @request = SmsCenter.const_get(platform, false).new(content, to_number, from_number, @@keys)
  end

  def send
    RestClient.post(@request.api_url, @request.body, @request.headers)
  end
end
