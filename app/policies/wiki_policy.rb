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

  class Scope
    attr_reader :user, :scope
 
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
 
    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private? || wiki.user == user || wiki.user(user)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.users.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end
end
