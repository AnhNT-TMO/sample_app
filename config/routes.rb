Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "users/new"
    root "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
  end
end