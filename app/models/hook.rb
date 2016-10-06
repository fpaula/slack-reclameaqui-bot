class Hook
  def self.trigger(params)
    score = Score.current(params)
    connection.post("services/#{ENV['SLACK_API_TOKEN']}", ScoreSerializer.new(score).to_json)
  end

  private

  def self.connection
    @connection ||= Faraday.new(:url => 'https://hooks.slack.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end
end
