Rails.application.routes.draw do
  namespace :admin do
    resources :charts, except: [:new, :create, :edit, :update, :show, :destroy, :index] do
      collection do
        get :new
        post '/show', action: :show
        get :resource_attributes
        get :data
      end
    end
  end
end
