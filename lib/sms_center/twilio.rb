class SmsCenter::Twilio
  attr_reader :api_url, :body, :headers
  def initialize(content, to_number, from_number, keys)
    base64key = Base64.strict_encode64("#{keys[:TWILIO_ACCOUNT_SID]}:#{keys[:TWILIO_AUTH_TOKEN]}")
    @api_url = "https://api.twilio.com/2010-04-01/Accounts/#{keys[:TWILIO_ACCOUNT_SID]}/Messages.json?"
    @headers = {
      'Authorization' => "Basic #{base64key}",
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
    @body = {
      From: from_number,
      To: to_number,
      Body: content
    }
  end
end
