json.extract!             @comment, :id
json.status               'created'

json.created_at           time_ago_in_words(@comment.created_at)
json.author_firstname     @comment.user.profile.firstname
json.author_lastname      @comment.user.profile.lastname
json.author_profile_id    @comment.user.profile.id
if @comment.user.profile.photo?
  json.author_profile_img   @comment.user.profile.photo.url('medium')
else
  json.author_profile_img   image_path('medium_missing.png')
end
json.body                 @comment.body
json.commentable_id       @comment.commentable.id
json.msg                  t('events.comments.your_comment_was_successfully_posted')
