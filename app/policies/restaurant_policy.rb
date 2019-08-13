class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope refers to the class
      # in this case its the Restaurant class
      scope.all # -> Restaurant.all
      # Multi tenant SAAS
      # scope.where(user: user)
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    false
  end

  def edit?
    # how can i check if the user is the owner?
    # restaurant.user == current_user
    # record correspond to the object that authorize is called on.
    # user corrosponds to current_user
    owner_or_admin
  end

  def update?
    owner_or_admin
  end

  def destroy?
    user.admin
  end

  def owner_or_admin
    record.user == user || user.admin
  end
end
