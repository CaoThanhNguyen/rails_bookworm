Rails.application.routes.draw do
  get "/" => "sessions#index"
  post "/sessions" => "sessions#create"
  delete "/sessions" => "sessions#destroy"
  
  post "/users" => "users#create"
  get "/users/:user_id" => "users#show"
  patch "/users/:user_id" => "users#update"
  delete "/users/:user_id" => "users#destroy"
  get "/users/:user_id/edit" => "users#edit"

  get "/books" => "books#index"
  post "/books" => "books#create"
  get "/books/new" => "books#new"
  get "/books/:book_id" => "books#show"

  post "/reviews/:book_id" => "reviews#create"
  delete "/reviews/:review_id" => "reviews#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
