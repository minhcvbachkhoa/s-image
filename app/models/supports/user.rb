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

  def images
    @images ||= user.images.order_by_created_at
  end
end
