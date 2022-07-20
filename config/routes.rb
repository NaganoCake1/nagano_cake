Rails.application.routes.draw do

  namespace :public do
    resources :addresses
  end

  namespace :public do
   resources :orders
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
