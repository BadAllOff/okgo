json.extract! @event_membership
json.event_id @event.id
json.status 'joined'
json.btn_text t'events.leave'
json.confirm_text t'are_you_sure'
json.leave_event_link leave_event_path(@event)
json.flash_msg t'event_memberships.you_have_joined_to_the_event_dont_be_late'