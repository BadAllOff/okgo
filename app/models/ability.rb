class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)

    alias_action :create, :read, :update, :destroy, to: :crud

    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, Event
    can :read, Feedback
    can :members, Event
  end

  def admin_abilities
    can :manage, :all
    can :access, :rails_admin   # grant access to rails_admin
    can :dashboard              # grant access to the dashboard
  end

  def user_abilities
    guest_abilities
    can :crud, Event, { user: user }
    can :crud, Feedback, { user: user }
    can :read, Profile
    can :update, Profile, { user: user }

    can :join, EventMembership
    can :as_tutor, EventMembership
    can :as_member, EventMembership
    can :member_attended, EventMembership
    can :leave, EventMembership, { user: user }
    can :create, Comment
    can :destroy, Comment, { user: user }
  end

end
