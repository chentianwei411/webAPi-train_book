require "rails_helper"

RSpec.describe "API_V1::Users", :type => :request do
  before do
    @user = User.create!( :email => "test@example.com", :password => "123123")
  end

  it "GET /me" do
    get '/api/v1/me', params:{ :auth_token => @user.authenication_token}
    expect(response).to have_http_status(200)
    @user.reload
    expect(response.body).to eq (
      {
        :email => @user.email,
        :image => @user.image,
        :updated_at => @user.updated_at,
        :created_at => @user.created_at
      }.to_json
    )
  end

  it "PATCH /me" do
    patch '/api/v1/me', params:{:auth_token => @user.authenication_token, :email => "test_change@example.com"}
    file = @user.image.attach(io: File.open("spec/fixtures/bose.jpg"), filename:"bose.jpg", content_type: "image/jpg")
    expect(response).to have_http_status(200)
    expect(response.body).to eq( {:message => "ok"}.to_json )
    @user.reload
    expect(@user.email).to eq("test_change@example.com")
    expect(@user.image).not_to eq(nil)
  end
end
