Rails.application.routes.draw do

  
  get 'suggests/index'
  namespace :links do
    get "/index" ,action: "index"
    get "/future_plan" ,action: "future_plan"
    get "/health" ,action: "health"
    get "/relationship" ,action: "relationship"
    get "/self_confidence" ,action: "self_confidence"
    get "/self_progress" ,action: "self_progress"
    get "/society" ,action: "society"
    get "/new" ,action: "new"
    post "/create" ,action: "create"
  end
  #get 'posts/index'
  #devise_for :users
 # get '/'=> 'home#index'
 devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'   
} 
  resources :posts do
    member do

      post "delete"
    end

  end

  namespace :walls do
    get "/:id/new" ,action: "new"
    post "/:id/create" ,action: "create"
    get "/:id/reply" ,action: "reply"
    post "/:id/update" ,action:  "update"
    post "/:id" ,action: "destroy"
  end

  namespace :friendships do
    get "/:id/index" ,action: "index"
    get "/:id/requested" ,action: "requested"
    #post "/:id/request" ,action: "request"
    delete "/:id/destroy" ,action: "destroy"
    put "/:id/accept" ,action: "accept"
    post "/:id/send_request" ,action: "send_request"
    get "/thanks" ,action: "thanks"
  end

  get "posts/:id/suggests/new" => "suggests#new"
  post "posts/:id/suggests/create" => "suggests#create"
 

  namespace :comments do
    get "/:id/reply" ,action: "reply"
    post "/:id/create_r" ,action: "create_r"
    get "/:id/edit" ,action:  "edit"
    post "/:id/update" ,action:  "update"
    post "/:id" ,action: "destroy"
  end

  get "posts/:id/comments/new" => "comments#new"
  post "posts/:id/comments/create" => "comments#create"

  namespace :users do
    get "/:id" ,action: "show"
    get "/:id/edit_name" ,action: "edit_name"
    put "/:id/update_name" ,action: "update_name"
  end

devise_scope :user do
  get "user/:id", :to => "users/registrations#detail"
  get "signup", :to => "users/registrations#new"
  get "login", :to => "users/sessions#new"
  get "logout", :to => "users/sessions#destroy"
end
  root 'home#index'
  get 'about' => "home#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
