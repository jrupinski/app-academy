AuthDemo::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resource :users
  resource :user, only: [:create, :new, :show] do
    resource :counter, only: [:update]
  end
end
