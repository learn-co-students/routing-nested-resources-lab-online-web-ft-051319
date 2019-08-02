Rails.application.routes.draw do
  resources :artists do
    resources :songs, only: [:show,:index]
  end
  resources :songs
end



# Rails.application.routes.draw do
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   resources :authors, only: [:show] do 
#     # nested resource for posts
#     resources :posts, only: [:show, :index]
    
#   end

#   resources :posts, only: [:index, :show, :new, :create, :edit, :update]

#   root 'posts#index'

# end
