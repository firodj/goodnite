require "test_helper"

class FollowsControllerTest < ActionDispatch::IntegrationTest
  test "new following return created" do
    john = users(:john)
    bob = users(:bob)

    post user_follow_path(bob.id, john.id)
    assert_response 201
  end

  test "already following return success" do
    john = users(:john)
    bob = users(:bob)
    Follow.create(user: bob, target: john)

    post user_follow_path(bob.id, john.id)
    assert_response 200
  end

  test "unfollow following return success" do
    john = users(:john)
    bob = users(:bob)
    Follow.create(user: bob, target: john)
    assert Follow.find_by(user: bob, target: john).present?

    delete user_follow_path(bob.id, john.id)
    assert_response 200

    assert !Follow.find_by(user: bob, target: john).present?
  end
end
