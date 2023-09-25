Rails.application.routes.draw do
  #deviseのroutes設定
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions" #sign_in機能のみ
  }
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations", #sign_up機能
    sessions: 'user/sessions' #sign_in機能
  }
  #ゲストログイン
  devise_scope :user do
    post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end
  #deviseのroutes設定ここまで

  #topページroutes設定
  root to: "user/homes#top"
  get 'admin' => 'admin/homes#top'
  get 'about' => 'user/homes#about'

  scope module: :admin do
    resources :caritems, only: [:new, :edit, :show, :update, :destroy, :create] do
      get :check, on: :collection
    end
    resources :multi_caritems, only: [:new, :create] do
    end
    resources :bodytypes, only: [:index, :edit, :update, :destroy, :create] do
    end
    resources :fuels, only: [:index, :edit, :update, :destroy, :create] do
    end
    resources :makers, only: [:index, :edit, :update, :destroy, :create] do
    end
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
    end
    resources :reviews, only: [:index, :show, :edit, :update, :destroy] do
      collection do
        get 'new_tag/:id', action: :new_tag, as: :new_tag
        patch 'create_tag/:id', action: :create_tag, as: :create_tag
        get 'edit_image/:id', action: :edit_image, as: :edit_image
        patch 'update_image/:id', action: :update_image, as: :update_image
      end
    end
    resources :comments, only: [:destroy] do
    end
  end

  namespace :user do
    #ジャンル
    resources :reviews, only: [:index, :create, :show, :edit, :update, :new, :destroy] do
      collection do
        get :search
        get :result
        get 'result_new_maker/:id', action: :result_new_maker, as: :result_new_maker
        get 'new_tag/:id', action: :new_tag, as: :new_tag
        patch 'create_tag/:id', action: :create_tag, as: :create_tag
        get 'edit_image/:id', action: :edit_image, as: :edit_image
        patch 'update_image/:id', action: :update_image, as: :update_image
        get 'tag_search/:id', action: :tag_search, as: :tag_search
        get :search_rev
        get 'result_rev_maker/:id', action: :result_rev_maker, as: :result_rev_maker
        get :result_rev_carname
        get :index_rev_carname
      end
      resources :comments, only: [:create, :destroy]
    end

    resources :caritems, only: [:index, :show] do
    end

    resources :car_searches, only: [:new] do
      collection do
        get :result
        get :failure
      end
    end

    get '/mypage' => 'users#show'
    get '/informaition/edit' => 'users#edit'
    patch '/update' => 'users#update'

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
