# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true # a modifier en false lorsqu'on fera les policies exactes
  end

  def show?
    true # a modifier en false lorsqu'on fera les policies exactes
  end

  def create?
    true # a modifier en false lorsqu'on fera les policies exactes
  end

  def new?
    create?
  end

  def update?
    true # a modifier en false lorsqu'on fera les policies exactes
  end

  def edit?
    update?
  end

  def destroy?
    true # a modifier en false lorsqu'on fera les policies exactes
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
