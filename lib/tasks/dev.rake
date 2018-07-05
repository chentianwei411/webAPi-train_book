# 编写任务script 执行bundle exec rake dev:fetch_city
namespace :dev do
  task :fetch_city => :environment do
    puts "Fetch city data..."
    # 从聚合数据网上，得到api钥匙，然后下载json格式的数据。
    response = RestClient.get "http://v.juhe.cn/weather/citys?key=JUHE_CONFIG["api_key"]"
    # 转化为hash格式
    data = JSON.parse(response.body)
    # 把数据存入创建的City数据库中。
    data["result"].each do |c|
      existing_city = City.find_by(juhe_id: c["id"])
      if existing_city.nil?
        City.create!(juhe_id: c["id"], province: c["province"], city: c["city"], district: c["district"])
      end
    end

    puts "Total: #{City.count} cities"
  end
end
