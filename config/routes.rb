Rails.application.routes.draw do


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
