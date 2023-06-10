json.extract! post, :id, :title, :body, :price, :color, :brand, :category, :sub_category, :web_link, :likes, :created_at, :updated_at
json.url post_url(post, format: :json)
