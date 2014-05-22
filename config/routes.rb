Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :rates do
    resources :rates, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :rates, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :rate_tables, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
