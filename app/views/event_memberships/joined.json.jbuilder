json.extract! @event_membership
json.event_id @event.id
json.status 'joined'
json.btn_text t'events.leave'
json.confirm_text t'are_you_sure'
json.leave_event_link leave_event_path(@event)