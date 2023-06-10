json.extract! collection, :id, :likes, :views, :body, :created_at, :updated_at
json.url collection_url(collection, format: :json)
