require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = User.create! name: "Example User", email: "example@gmail.com",
      password: "foobar", password_confirmation: "foobar", admin: 1
    @caominh = User.create! name: "Cao Minh", email: "minhcv@gmail.com",
      password: "minhcv", password_confirmation: "minhcv", admin: 0
    @other_user = User.create! name: "Other User", email: "other@gmail.com",
      password: "foobar", password_confirmation: "foobar", admin: 0

    @group = Group.create! name: "Dakrai", policy: "is_public"

    GroupUser.create! group_id: @group.id, user_id: @caominh.id,
      admin_group: true
    GroupUser.create! group_id: @group.id, user_id: @user.id,
      admin_group: false

    @current_user = @caominh
  end

  describe "#not_admin" do
    it {expect(User.not_admin).to eq [@caominh, @other_user]}
  end

  describe "#is_admin_group?" do
    it {expect(@caominh.is_admin_group?(@group)).to eq true}
    it {expect(@user.is_admin_group?(@group)).to eq false}
  end

   describe "#current_user?" do
    it {expect(@current_user.current_user?(@user)).to eq false}
    it {expect(@current_user.current_user?(@caominh)).to eq true}
  end

  describe "#follow" do
    before do
      @relationship = @current_user.follow @other_user
    end

    it {expect(@current_user.following.size).to eq 1}
    it {expect(@current_user.followers.size).to eq 0}

    it {expect(@other_user.following.size).to eq 0}
    it {expect(@other_user.followers.size).to eq 1}

    it {expect(@current_user.followed?(@other_user)).to eq true}
    it {expect(@current_user.followed?(@user)).to eq false}

    describe "#user_relationship" do
      it {expect(@relationship).to eq @current_user
        .user_relationship(@other_user)}
    end

    describe "#unfollow" do
      before do
        @current_user.unfollow @other_user
      end
      it {expect(@current_user.following.size).to eq 0}
    end
  end
end
