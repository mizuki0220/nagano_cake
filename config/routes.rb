Rails.application.routes.draw do
  devise_for :cart_items
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'homes#top'
    resources :genres, only: [:index, :edit, :create, :update]
  end

  scope module: :public do
    root to: 'homes#top'

    get 'home/about' => 'homes#about', as: 'about'

    devise_for :customers, skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: "public/sessions"
    }
    resources :customers, only: [:show, :edit, :update]
    get '/customers/my_page', to: 'customers#show'
    get '/customers/information/edit', to: 'customers#edit'
    get '/customers/information', to: 'customers#update'
    resources :customers do
      member do
        patch 'withdraw'
        get 'unsubscribe'
      end
    end

    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :cart_items do
      collection do
        delete 'destroy_all'
      end
    end

    resources :items, only: [:index, :show]

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
