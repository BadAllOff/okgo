json.extract! @event_membership
json.event_id @event.id
json.status 'leaved'
json.btn_text t'events.join'
json.join_event_link join_event_path(@event)
json.flash_msg t'event_memberships.you_have_left_the_event'