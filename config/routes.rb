require 'sidekiq/web'

Magpie::Application.routes.draw do
  devise_for :admins, controllers: { sessions: "admins/sessions" }

  resources :projects do
    resources :project_layers, except: [:new] do
      match ':type' => 'project_layers#new', on: :new, as: :subclass
    end
  end

  resources :workspaces, only: [:show, :create], shallow: true do
    resources :areas_of_interest, only: [:show, :create, :update, :destroy], shallow: true do
      resources :polygons, only: [:show, :create, :update, :destroy] do
        collection do
          get "new_upload_form"
          post "create_from_file"
        end
      end
    end
  end

  resources :polygon_uploads, only: [:show]

  constraint = lambda { |request| request.env["warden"].authenticate? }
  constraints constraint do
    mount Sidekiq::Web => '/sidekiq'
  end

  root :to => 'projects#index'
end
