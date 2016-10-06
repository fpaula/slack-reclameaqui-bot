class HooksController < ActionController::API
  include ActionController::Serialization

  def index
    Hook.trigger(permitted_params)
    render nothing: true
  end

  private

  def permitted_params
    params.permit(:company_id, :period)
  end
end
