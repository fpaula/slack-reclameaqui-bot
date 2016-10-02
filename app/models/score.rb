class Score
  include ActiveModel::Serializers::JSON

  TYPES = {
    past_last_year: 'PAST_LAST_YEAR',
    last_3_years: 'LAST_THREE_YEARS',
    last_12_months: 'TWELVE_MONTHS',
    last_6_months: 'SIX_MONTHS',
    last_year: 'LAST_YEAR'
  }

  attr_accessor :total_not_answered,
    :total_complains,
    :consumer_score,
    :solved_percentual,
    :total_answered,
    :average_answer_time3_m,
    :total_evaluated,
    :answered_percentual,
    :deal_again_percentual,
    :status

  def initialize(params)
    @total_not_answered = params[:totalNotAnswered]
    @total_complains = params[:totalComplains]
    @consumer_score = params[:consumerScore]
    @solved_percentual = params[:solvedPercentual]
    @total_answered = params[:totalAnswered]
    @average_answer_time3_m = params[:averageAnswerTime3M]
    @total_evaluated = params[:totalEvaluated]
    @answered_percentual = params[:answeredPercentual]
    @deal_again_percentual = params[:dealAgainPercentual]
    @status = params[:status]
  end

  def self.current(params)
    company_id = params[:company_id]
    period = params.fetch(:period, :last_12_months)

    company_index(company_id, TYPES[period.to_sym])
  end

  def self.company_index(company_id, type)
    body = connection.get("/raichu-io-site-0.0.1-SNAPSHOT/companyindex/company/#{company_id}").body
    full_score = JSON.parse(body, symbolize_names: true)[:data]
    selected_score = full_score.find{|score| score[:type] == type }

    new(selected_score)
  end

  private

  def self.connection
    @connection ||= Faraday.new(:url => 'https://iosite.reclameaqui.com.br') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end
end
