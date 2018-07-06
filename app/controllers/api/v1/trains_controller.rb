class Api::V1::TrainsController < ApiController
  def index
    # @trains = Train.all
    # 使用分页功能gem 'kaminari'
    @trains = Train.order(:created_at).page(params[:page])
    # render :json => {
    #   :data => @trains.map { |train|
    #     { :number => train.number,
    #         :train_url => api_v1_train_url(train.number)
    #     }
    #   }
    # }
  end
  # 点击链接 api_v1_train_url(train.number):
  # Started GET "/api/v1/trains/0822" for ::1 at 2018-07-05 18:32:20 +0800
  # Processing by Api::V1::TrainsController#show as HTML
  #   Parameters: {"default"=>{"format"=>:json}, "train_number"=>"0822"}
  def show
    @train = Train.find_by_number!(params[:train_number])

    #写到show.json.jbuilder了
    # render :json => {
    #   :number => @train.number,
    #   :available_seats => @train.available_seats
    # }
  end


end
