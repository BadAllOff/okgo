json.extract! @socializable

json.obj_id         @socializable.id
json.like           true
json.likers_count   @socializable.likers_count
json.btn_class      'btn-primary'
json.link           send("#{@socializable.class.name.downcase}_unlike_path", @socializable)
json.method         'delete'
json.likable        @socializable.class.name.to_s.downcase