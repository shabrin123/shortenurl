json.array!(@shortened_urls) do |shortened_url|
  json.extract! shortened_url, :id
  json.url shortened_url_url(shortened_url, format: :json)
end
