Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    resources :accounts, only: [:create, :show]
    patch '/accounts/deposit/:id', to: 'accounts#deposit'
    patch '/accounts/withdraw/:id', to: 'accounts#withdraw'
  end
end
