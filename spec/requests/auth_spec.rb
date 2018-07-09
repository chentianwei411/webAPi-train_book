require 'rails_helper'

RSpec.describe "API_V1::Auth", :type => :request do

  describe "signup" do
    it "register" do
      post "/api/v1/signup", params:{:email => "test2@example.com", :password => "123123"}
      expect(response).to have_http_status(200)

      new_user = User.last
      expect(new_user.email).to eq("test2@example.com")
      expect(response.body).to eq({ :user_id => new_user.id }.to_json )
    end

    it "register failed" do
      post "/api/v1/signup", params:{:email => "test2@example.com" }
      expect(response).to have_http_status(400)
      puts "#{response.body}"
      expect(response.body).to eq({ :message => "Failed", :errors => {:password => ["can't be blank"]} }.to_json )
    end
  end

  describe "login and logout" do
    before do
      @user = User.create!( :email => "text@example.com", :password => "123456")
    end

    it "valid login and logout" do
      post '/api/v1/login', params:{email: @user.email, password: "123456"}
      expect(response).to have_http_status(200)
      expect(response.body).to eq(
        {
          :message => "Ok",
          :auth_token => @user.authenication_token,
          :user_id => @user.id
        }.to_json
      )
      # logout方法，需要先验证当前用户，否则报错：
      post '/api/v1/logout'
      expect(response).to have_http_status(401)

      post '/api/v1/logout', params:{ :auth_token => @user.authenication_token }
      expect(response).to have_http_status(200)
      old_token = @user.authenication_token
      @user.reload

      expect(@user.authenication_token).not_to eq old_token
    end

    it "invalid auth login" do
      post "/api/v1/login", params: { :email => @user.email, :password => "xxdx" }
      expect(response).to have_http_status(401)
      expect(response.body).to eq({:message => "Email or Password is wrong"}.to_json)
    end
  end
end
