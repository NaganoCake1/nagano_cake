Rails.application.routes.draw do

  namespace :public do
    resources :cart_items,only: [:index, :create, :update, :destroy] do
      collection do
        delete "destroy_all"
      end
    end
  end
  namespace :public do
    resources :addresses,only: [:index, :create, :show, :edit, :update, :destroy]
  end

  namespace :public do
    resources :orders,only: [:new, :index, :histry] do

      collection do
        delete "destroy_all"
      end
    end
    post "orders/check" => 'orders#check'
    post "orders/comfilm" => 'orders#comfilm'
    get "orders/complete" => 'orders#complete'
    get "orders/:id" => 'orders#histry', as: 'order/histry'
  end

  namespace :public do
    resources :customers
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
  end
  namespace :public do
    resources :items
  end
  namespace :admin do
    resources :order_details
  end
  namespace :admin do
    resources :orders
  end
  namespace :admin do
    root to: 'homes#top'
  end
  namespace :public do
    root to: 'homes#top'
    get "/home/about" => "homes#about", as: "about"

  end
  namespace :admin do
    resources :customers
  end
  namespace :admin do
    resources :items
  end
  namespace :admin do
    resources :genres
  end

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
