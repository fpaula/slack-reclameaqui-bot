Rails.application.routes.draw do
  resources :scores, only: :index
end
