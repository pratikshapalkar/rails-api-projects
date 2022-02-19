Rails.application.routes.draw do
  # get 'categories/index'
  # get 'categories/show'
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
     registrations: 'registrations', sessions: 'sessions'
  }
  devise_scope :user do
    resources :products, controller: :products do
        resources :categories do
        end
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

