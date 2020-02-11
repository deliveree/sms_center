class SmsCenter::Nexmo
  attr_reader :api_url, :body, :headers
  def initialize(content, to_number, from_number, keys)
    base64key = Base64.strict_encode64("#{keys[:NEXMO_API_KEY]}:#{keys[:NEXMO_API_SECRET]}")
    @api_url = 'https://rest.nexmo.com/sms/json'
    @body = {
      api_key: keys[:NEXMO_API_KEY],
      api_secret: keys[:NEXMO_API_SECRET],
      to: to_number,
      text: content,
      from: from_number
    }
  end
end
