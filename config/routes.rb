Rails.application.routes.draw do
  match 'scores', to: 'scores#index', via: [:get, :post]
end
