Rails.application.routes.draw do
  resources :cities do
    member do
      post :update_temp
    end
  end
  # 
  # GET /trains
  # GET /trains/{列车编号}
  # POST /reservations/{订票号码}
  # GET /reservations/{订票号码}
  # PATCH /reservations/{订票号码}
  # DELETE /reservations/{订票号码}

  root "cities#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
