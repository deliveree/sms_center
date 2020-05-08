class SmsCenter
  autoload :Infobip,    'sms_center/infobip'
  autoload :Nexmo,      'sms_center/nexmo'
  autoload :Twilio,     'sms_center/twilio'
  autoload :Telerivet,  'sms_center/telerivet'
  autoload :Plivo,      'sms_center/plivo'

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

  def initialize(content, to_number, options = {})
    country = options[:country]
    platform = options[:platform]

    f_platform = platform.present? ? platform.downcase.capitalize : platform_by_country(country, to_number)

    from_number = SmsCenter.root_number_by_platform[f_platform.to_sym]
    @request = SmsCenter.const_get(f_platform, false).new(content, to_number, from_number, @@keys)
  end

  def send
    HTTPClient.new.post_async(@request.api_url, @request.body, @request.headers)
  end

  def send_and_wait
    HTTPClient.new.post(@request.api_url, @request.body, @request.headers)
  end

  private
  def platform_by_country(country, to_number)
    platform_by_country = SmsCenter.platform_by_country
    platform = platform_by_country[country.downcase.to_sym] if country.present?
    if platform.is_a?(Hash)
      phone = Phonelib.parse(to_number, country.downcase.to_sym)
      platform_by_carrier = platform[phone.carrier&.to_sym]
      platform = platform_by_carrier.present? ? platform_by_carrier : platform[:default]
    elsif platform.nil?
      platform = platform_by_country[:default]
    end
    platform.downcase.capitalize
  end
end
