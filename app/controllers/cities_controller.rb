class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def update_temp
    city = City.find(params[:id])

    # response = RestClient.get "http://v.juhe.cn/weather/index?format=2&cityname=%E8%8B%8F%E5%B7%9E&key=214b163d003a4799cb76359b6d30b7de"
    response = RestClient.get "http://v.juhe.cn/weather/index",
                          :params => { :cityname => city.juhe_id, :key => JUHE_CONFIG["api_key"] }
    data = JSON.parse(response.body)
    city.update( :current_temp => data["result"]["sk"]["temp"])
    redirect_to cities_path
  end
end
