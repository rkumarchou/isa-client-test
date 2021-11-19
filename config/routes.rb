require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post :sign_up, to: 'registrations#create'

      resources :queue_jobs, only: %i[index create] do
        post :worker, on: :member
      end
    end
  end
end
