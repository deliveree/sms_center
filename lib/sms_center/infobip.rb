class SmsCenter::Infobip
  attr_reader :api_url, :body, :headers
  def initialize(content, to_number, from_number, keys)
    api_key = keys[:INFOBIP_API_KEY]
    @api_url = 'https://5mzkg.api.infobip.com/sms/2/text/single'
    @headers = {
      'Authorization' => "App #{api_key}",
      'Content-Type' => 'application/json'
    }
    @body = {
      "to": to_number,
      "text": content,
    }
    @body["from_number"] = from_number if from_number
  end
end
