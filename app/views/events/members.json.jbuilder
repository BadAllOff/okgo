json.event_id @event.id
json.members @members do |member|
  json.user_id member.user_id
  json.name member.profile.firstname
  json.profile_image_medium member.profile.photo.url('medium')
  json.link_to_profile profile_path(member.profile)
end