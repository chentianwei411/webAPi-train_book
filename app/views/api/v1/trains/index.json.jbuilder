# 加入分页功能
json.meta1 do
  json.current_page @trains.current_page
  json.total_pages @trains.total_pages
  json.per_page @trains.limit_value
  json.total_trains Train.count

  if @trains.current_page == @trains.total_pages
    json.next_url nil # 最后一页就没有下一页了
  else
    json.next_url api_v1_trains_url(page: @trains.next_page )
  end

  if @trains.current_page == 1
    json.previous_url nil # 第一页就没有上一页
  else
    json.previous_url api_v1_trains_url( :page => @trains.prev_page )
  end
end

json.data do
  # json.array! @trains do |train|
  #   json.number train.number
  #   json.train_url api_v1_train_url(train.number)
  # end

  json.partial! 'item', collection: @trains, :as => :train
  #另外一种写法： json.array! @trains, :as => :train, partial: 'item'
end
