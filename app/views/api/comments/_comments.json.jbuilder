json.comments comments do |comment|
  json.author "#{comment.author.first_name} #{comment.author.last_name}"
  json.author_id comment.author_id
  json.title comment.title
  json.body comment.body
  json.created_at comment.created_at
end
