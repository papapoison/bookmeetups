Bookmeetups::Application.routes.draw do
  root to: 'users#new'

  post "/search", to: "searches#search"
  resources :users do
    post 'books/:book_id', to: 'user_books#create', as: 'create'
    delete 'books/:book_id', to: 'user_books#destroy', as: 'book'
    get 'books', to: 'user_books#index'
    get 'books/:book_id/new_meetup', to: 'meetups#create', as: 'create_meetup'
    resources :meetups, :except => [:new, :edit, :create, :destroy]
    resources :photos, :only => [:show, :new, :create, :destroy] do
      get "serve", :on => :member
    end
  end

  resources :books, only: [:create, :show, :index]
  resources :sessions, :only => [:new, :create, :destroy]

  resources :meetups, :only => [] do
    resources :messages, only: [:new, :create]
  end


  get "/search/:s", to: "searches#results"
  get "/search", to: "searches#results"
end
