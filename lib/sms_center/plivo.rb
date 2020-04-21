class SmsCenter::Plivo
  attr_reader :api_url, :body, :headers
  def initialize(content, to_number, from_number, keys)
    base64key = Base64.strict_encode64("#{keys[:PLIVO_ACCOUNT_SID]}:#{keys[:PLIVO_AUTH_TOKEN]}")
    @api_url = "https://api.plivo.com/v1/Account/#{keys[:PLIVO_ACCOUNT_SID]}/Message/"
    @headers = {
      'Authorization' => "Basic #{base64key}"
    }
    @body = {
      src: from_number,
      dst: to_number,
      text: content
    }
  end
end