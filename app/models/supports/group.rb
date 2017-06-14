class Supports::Group
  attr_reader :group

  def initialize group
    @group = group
  end

  def group_user user
    @group_user = group.group_users.find_by user_id: user.id
  end

  def images
    @images ||= group.images.order_by_created_at
  end
end
