desc 'Counter cache for user has many events and event_memberships'

task user_counter: :environment do
  User.reset_column_information
  User.all.each do |p|
    User.reset_counters p.id, :events
    User.reset_counters p.id, :event_memberships
  end
end

task members_counter: :environment do
  Event.reset_column_information
  Event.all.each do |p|
    Event.reset_counters p.id, :memberships
  end
end