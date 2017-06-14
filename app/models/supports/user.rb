class Supports::User
  attr_reader :user

  def initialize user
    @user = user
  end

  def followers
    @followers ||= user.followers
  end

  def following
    @following ||= user.following
  end
end
