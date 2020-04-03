class SmsCenter::Telerivet
  attr_reader :api_url, :body, :headers
  def initialize(content, to_number, from_number, keys)
    base64key = Base64.strict_encode64("#{keys[:TELERIVET_API_KEY]}:")
    @api_url = "https://api.telerivet.com/v1/projects/#{keys[:TELERIVET_PROJECT_ID]}/messages/send"
    @headers = {
      'Authorization' => "Basic #{base64key}"
    }
    @body = {
      "content": content,
      "to_number": to_number
    }.to_json
    @body["from_number"] = from_number if from_number
  end
end
