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

  test "sleeps from following" do
    bob = users(:bob)
    alice = users(:alice)
    susan = users(:susan)

    travel_to Time.utc(2022, 06, 10, 8, 0, 0) do
      get sleeps_user_follows_path(bob.id)
    end
    assert_response 200

    data = @response.parsed_body
    assert_equal 2, data.size
    assert_equal susan.id, data[0]['user_id']
    assert_equal alice.id, data[1]['user_id']
  end
end
