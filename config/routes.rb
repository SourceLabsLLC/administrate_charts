Rails.application.routes.draw do
  namespace :admin do
    resources :dashboards, except: [:new, :create, :edit, :update, :show, :destroy, :index] do
      collection do
        get :new
        get '/show', action: :show
        get :resource_attributes
        get :chart_data
      end
    end
  end
end
