json.data do
  json.partial! 'item', collection: @reservations, :as => :reservation
end
