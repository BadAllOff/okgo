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
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :crud, Event, { user: user }
    can :read, Profile
    can :update, Profile, { user: user }

    can :join, EventMembership
    can :as_tutor, EventMembership
    can :as_member, EventMembership
    can :member_attended, EventMembership
    can :leave, EventMembership, { user: user }
  end
  #
  # The first argument to `can` is the action you are giving the user
  # permission to do.
  # If you pass :manage it will apply to every action. Other common actions
  # here are :read, :create, :update and :destroy.
  #
  # The second argument is the resource the user can perform the action on.
  # If you pass :all it will apply to every resource. Otherwise pass a Ruby
  # class of the resource.
  #
  # The third argument is an optional hash of conditions to further filter the
  # objects.
  # For example, here the user can only update published articles.
  #
  #   can :update, Article, :published => true
  #
  # See the wiki for details:
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
end
