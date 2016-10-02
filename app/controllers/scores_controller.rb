class ScoresController < ActionController::API
  include ActionController::Serialization

  def index
    render json: Score.current(permitted_params)
  end

  private

  def permitted_params
    params.permit(:company_id, :period)
  end
end
