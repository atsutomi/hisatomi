Customize::Application.routes.draw do
  root to: "dishes#top"
  get "dishes/index"
  put 'orders/:id' => "orders#create"
  resources :dishes, only: [:index, :show]do
    collection { get "top" }
    collection { get "search" }
    member { get "order" }
  end
 
  resource :session, only: [:create, :destroy]

  resource :account, only: [:edit, :update]

  resources :orders, except: [:edit, :update] do
    collection { post "check" }
  end

  resources :members, only: [:new, :create]

  namespace :admin do
    root to: "orders#index"
    put 'orders/:id' => "orders#check"
    resources :reserves, except: [:new, :create]
    resources :stocks, only: [:edit, :update, :index] do
      collection { get "index_all" }
      collection { get "show_date" }
    end
    resources :dishes, except: [:destroy]do
      collection { get "search" }
      member { get "order" }
    end
    resources :members, only: [:index, :show]
    resources :orders, only: [:index, :show, :edit, :destroy] do
      collection { post "check" }
      collection { get "all_order" }
      collection { post "update" }
    end
  end

  match ':controller(/:action(/:id))(.:format)'


end
