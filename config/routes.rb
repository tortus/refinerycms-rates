Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :rates do
    root :to => 'rate_tables#index'
    resources :rate_tables, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :rates, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      scope :path => 'rates' do
        root :to => 'rate_tables#index'
        resources :rate_tables, :except => :show
      end
    end
  end

end
