require "test_helper"

class FollowTest < ActiveSupport::TestCase
  test "follower" do
    got = users(:bob).friends.pluck(:name)
    assert_equal ["Alice", "Susan"], got.sort
  end
end
