Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  get '/', to: redirect('/stores')
  get '/home', to: redirect('/stores')
  get '/suppliers', to: redirect('/stores')
  get '/stores/:id', to: 'home#index'
  get '/suppliers/:id', to: redirect('/stores')
  resources :stores, controller: "suppliers", as: 'suppliers', only: [:create, :new, :index, :show]
end
