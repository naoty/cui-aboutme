CuiAboutme::Application.routes.draw do
  scope '/', defaults: { format: :text } do
    get    'users'     => 'users#index'
    get    ':id'       => 'users#show'
    get    ':id/man'   => 'users#man'
    get    ':id/:item' => 'users#item'
    post   'signup'    => 'users#create'
    put    ':id'       => 'users#update'
    delete ':id'       => 'users#destroy'
  end

  root to: 'home#index'
end
