json.title          @blog.title
json.content        strip_tags(@blog.content)
json.category_name  @blog.blog_category_name
json.category_blogs blogs_url(category: @blog.blog_category_id)
json.created_at     @blog.created_at.to_s(:db)
json.comments_count @blog.comments.count
json.comments @comments do |comment|
  json.avatar       avatar_url(comment.user, params[:avatar_size] || 50)
  json.name         comment.name
  json.content      h(comment.content)
  json.created_at   comment.created_at.to_s(:db)
end
