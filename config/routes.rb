Rails.application.routes.draw do
  root 'home#index'

  mount ActionCable.server => '/cable'

  #Home
  get '/home/help', to: 'home#help'
  get '/home/contact', to: 'home#contact'

  # User
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    # get 'sign_out', to: 'devise/sessions#destroy'
  end

  # Post
  resources :posts

  # Api
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :post do
        get 'like', to: 'posts#like'
        post 'comment', to: 'posts#comment'
        delete 'comment/destroy', to: 'posts#destroy_comment'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
