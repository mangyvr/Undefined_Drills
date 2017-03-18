Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
<<<<<<< HEAD

  resources :users, only: [:new, :create] do
    resources :reset_password, only: [:new, :create, :edit, :update]
  end

  resources :sessions, only: [:new, :create]

=======
  root to: "home#index"
  resources :groups, shallow: true do
    resources :drills, shallow: true do
      resources :answers, shallow: true
    end
  end
>>>>>>> 0d7cf86fc9f3b32fa2a700efb1cc77c032a027c6
end
