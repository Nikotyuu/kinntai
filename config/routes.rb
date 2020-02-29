Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  get 'users/kyoten', to: 'users#kyoten'
  get 'users/syukkin', to: 'users#syukkin'
  get 'users/kintaihensyuu', to: 'users#kintaihensyuu'
  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  

  

  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      patch 'update_user_info'
      get 'attendances_edit_log'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get 'edit1_basic_info' #この行が残業申請モーダルウィンドウです
      patch 'update_basic1_info' #この行が残業申請モーダルウィンドウです
      get 'edit2_basic_info'
      patch 'update_basic2_info'
      get 'edit3_basic_info'
      patch 'update_basic3_info'
      get 'edit4_basic_info'
      patch 'update_basic4_info'
 
    end
    resources :attendances, only: :update
  end
end