Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'homes#top'
  end

  scope module: :public do
    root to: 'homes#top'

    get 'home/about' => 'homes#about', as: 'about'
    get 'customers/:id' => 'customer#show', as: 'my_page'

    devise_for :customers, skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: "public/sessions"
    }

    resources :customers do
      member do
        patch 'withdraw'
        get 'unsubscribe'
      end
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
