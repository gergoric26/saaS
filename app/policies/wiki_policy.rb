class WikiPolicy
  attr_reader :current_user, :wiki

  def initialize(current_user, wiki)
    @current_user = current_user
    @wiki = wiki
  end

#  def index?
#    false
#  end

#  def show?
#    scope.where(:id => record.id).exists?
#  end

#  def create?
#    false
#  end

#  def new?
#    create?
#  end

  def update?
    @current_user.admin? || @current_user == @wiki.user
  end

  def edit?
    update?
  end

#  def destroy?
#    false
#  end

#  def scope
#    Pundit.policy_scope!(user, record.class)
#  end

#  class Scope
#    attr_reader :user, :scope

#    def initialize(user, scope)
#      @user = user
#      @scope = scope
#    end

#    def resolve
#      scope
#    end
#  end
end
