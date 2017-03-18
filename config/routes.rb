Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create] do
    resources :reset_password, only: [:new, :create, :edit, :update]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

end
