json.number train.number

if train.logo.attached?
  json.logo_url
  json.logo_file_size train.logo.blob.filename
  json.logo_content_type train.logo.blob.content_type
else
  json.logo_url nil
  json.logo_file_size nil
  json.logo_content_type nil
end

json.available_seats train.available_seats
json.created_at train.created_at
