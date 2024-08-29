Rails.application.routes.draw do
  devise_for :users

  resources :items, only: [:show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'view_all', to: 'items#view_all'
    end
  end

  resources :users, only: [:edit, :update, :destroy]
  get 'view_users', to: 'users#view_all'

  resources :players do
    member do
      get 'inventory', to: 'inventories#index'
      patch 'equip_item/:item_id', to: 'inventories#equip_item', as: 'equip_item'
      patch 'unequip_item/:item_id', to: 'inventories#unequip_item', as: 'unequip_item'
      patch 'level_up', to: 'players#level_up', as: 'level_up'
      patch 'allocate_points', to: 'players#allocate_points', as: 'allocate_points'
    end

    collection do
      get 'view_all', to: 'players#view_all'
    end
  end

  resources :quests do
    member do
      get 'start_quest', to: 'quests#start_quest'
    end
    resources :steps, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
      post 'answer', on: :member
    end
  end

  resources :battles, only: [:show, :create] do
    member do
      patch 'attack'
    end
  end

  get 'welcome' => 'pages#home'
  get 'view_users', to: 'users#view_all'

  root 'pages#home'
end
