Rails.application.routes.draw do

  post '/auth/auto' => 'authentication#auto_login'
  post '/auth/login' => 'authentication#login'

  namespace :api do
    namespace :v1 do
      resources :users
      resources :clubs
      resources :comments
      resources :boards
      resources :memberships, only: [:create, :destroy]
    end
  end

  get '*path', to: 'application#fallback_index_html', constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end