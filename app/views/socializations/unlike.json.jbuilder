json.obj_id @socializable.id

json.like             false
json.likers_count     @socializable.likers_count
json.btn_class        'btn-default'
json.link             send("#{@socializable.class.name.downcase}_like_path", @socializable)
json.method           'post'
json.likable          @socializable.class.name.to_s.downcase