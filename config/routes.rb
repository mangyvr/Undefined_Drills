Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create]

  # Reset password must be independent of users -- no associated user yet
  resources :reset_password, only: [:new, :create, :edit, :update]

  get "/auth/twitter", as: :sign_in_with_twitter
  get "/auth/twitter/callback" => "callback#twitter"
  get "/auth/facebook", as: :sign_in_facebook
  get "/auth/facebook/callback" => "callback#facebook"

  patch '/users/:id/edit_password' => 'users#edit_password', as: :edit_password

  resources :users, only: [:new, :create, :update, :edit, :destroy] do
    resources :validate_email, only: [:create, :update]
  end

  resources :reset_password, only: [:new, :create, :edit, :update]

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
