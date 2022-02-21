Rails.application.routes.draw do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
       registrations: 'registrations', sessions: 'sessions'
    }
    devise_scope :user do
      resources :sports, controller: :sports do
          resources :posts do
            resources :anouncements do
              resources :achievements
            end
          end
        end
      end
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
