Rails.application.routes.draw do

  namespace :public do

    #scope module: :public do

      resources :cart_items,only: [:index, :create, :update, :destroy] do
        collection do
          delete "destroy_all"
        end
      end

      resources :addresses,only: [:index, :create, :show, :edit, :update, :destroy]

      resources :orders,only: [:new, :index, :histry] do

        collection do
          delete "destroy_all"
        end
      end

      post "orders/check" => 'orders#check'
      post "orders/comfilm" => 'orders#comfilm'
      get "orders/complete" => 'orders#complete'
      get "orders/:id" => 'orders#show', as: 'order/histry'

      resources :customers
      get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
      patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'

      resources :items

      root to: 'homes#top'
      get "/home/about" => "homes#about", as: "about"

    #end

  end


  namespace :admin do
    resources :order_details

    resources :orders

    root to: 'homes#top'

    resources :customers

    resources :items

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
