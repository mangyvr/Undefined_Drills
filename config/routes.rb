Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/auth/twitter", as: :sign_in_with_twitter
  get "/auth/twitter/callback" => "callback#twitter"
  get "/auth/facebook", as: :sign_in_facebook
  get "/auth/facebook/callback" => "callback#facebook"

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  resources :users, only: [:new, :create] do
    resources :reset_password, only: [:new, :create, :edit, :update]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root to: "home#index"
  resources :groups, shallow: true do
    resources :drills, shallow: true do
      resources :answers, shallow: true
    end
  end

end
