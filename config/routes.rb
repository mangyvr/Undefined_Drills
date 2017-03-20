Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    get :stats, on: :member
  end
  resources :users do
    get :bookmarks, on: :member
  end

  # Reset password must be independent of users -- no associated user yet
  resources :reset_password, only: [:new, :create, :edit, :update]

  get "/auth/twitter", as: :sign_in_with_twitter
  get "/auth/twitter/callback" => "callback#twitter"
  get "/auth/facebook", as: :sign_in_facebook
  get "/auth/facebook/callback" => "callback#facebook"


  namespace :admin do
    patch "dashboard/activate_user/:id" => "dashboard#activate_user", as: :activate_user
    patch "dashboard/validate_user/:id" => "dashboard#validate_user", as: :validate_user
    delete "dashboard/delete_user/:id" => "dashboard#delete_user", as: :delete_user
    delete "dashboard/delete_group/:id" => "dashboard#delete_group", as: :delete_group
    patch "dashboard/change_drill_metrics/:id" => "dashboard#change_drill_metrics", as: :change_drill_metrics
    delete "dashboard/delete_drill/:id" => "dashboard#delete_drill", as: :delete_drill
    patch "dashboard/approve_answer/:id" => "dashboard#approve_answer", as: :approve_answer
    delete "dashboard/delete_answer/:id" => "dashboard#delete_answer", as: :delete_answer
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
    resources :user_groups, only: [:create, :destroy]
    resources :drills, shallow: true do
      resources :answers
      resources :user_answers, only: [:create]
    end
  end

end
