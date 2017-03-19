Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :index]

  # Reset password must be independent of users -- no associated user yet
  resources :reset_password, only: [:new, :create, :edit, :update]

  get "/auth/twitter", as: :sign_in_with_twitter
  get "/auth/twitter/callback" => "callback#twitter"
  get "/auth/facebook", as: :sign_in_facebook
  get "/auth/facebook/callback" => "callback#facebook"


  namespace :admin do
    patch "dashboard/activate_user/:id" => "dashboard#activate_user", as: :activate_user
    patch "dashboard/validate_user/:id" => "dashboard#validate_user", as: :validate_user
    resources :dashboard, only: [:index]
  end

  patch '/users/:id/edit_password' => 'users#edit_password', as: :edit_password

  resources :users, only: [:new, :create, :update, :edit, :destroy] do
    resources :validate_email, only: [:new, :edit, :update]
  end

  resources :reset_password, only: [:new, :create, :edit, :update]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root to: "home#index"
  resources :groups, shallow: true do
    resources :drills, shallow: true do
      resources :answers
      resources :user_answers, only: [:create]
    end
  end

end
