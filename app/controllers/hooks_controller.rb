class HooksController < ActionController::API
  include ActionController::Serialization

  before_action :check_token

  def index
    Hook.trigger(permitted_params)
    render nothing: true
  end

  private

  def check_token
    if params[:ifttt_token] != ENV['IFTTT_TOKEN']
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def permitted_params
    params.permit(:company_id, :period, :ifttt_token)
  end
end
