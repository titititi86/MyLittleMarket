class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif user
      alias_action :create, :read, :update, :destroy, :to => :crud
      alias_action :read, :update, :destroy, :to => :rud

      can :rud, User, :id => user.id
      can :crud, Product
      # , :user_id => user.id
      # can :crud, Category
      # can :crud, Contact, :user_id => user.id

    end

    # can :read, User
    # can :create, User
    can :read, Product
    # can :create, Product

  end


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
  # https://github.com/ryanb/cancan/wiki/Defining-Abilities

end
