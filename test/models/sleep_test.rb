require "test_helper"

class SleepTest < ActiveSupport::TestCase
  test "validate wakeup_at greater sleep_at" do
    user = users(:john)

    s1 = Sleep.new(
      user_id: user.id,
      wakeup_at: "2021-02-10T04:00:00",
      sleep_at: "2021-02-10T05:00:00"
    )
    assert !s1.valid?

    s2 = Sleep.new(
      user_id: user.id,
      sleep_at: s1.wakeup_at,
      wakeup_at: s1.sleep_at,
    )

    assert s2.valid?
  end

  test "validate no overlap" do
    bob = users(:bob)
    john = users(:john)

    bob.sleeps.create!(sleep_at: "2021-02-10T04:00:00", wakeup_at: "2021-02-10T10:00:00")

    s1 = john.sleeps.new(sleep_at: "2021-02-10T08:00:00", wakeup_at: "2021-02-10T12:00:00")
    assert s1.valid?

    s2 = bob.sleeps.new(sleep_at: "2021-02-10T08:00:00", wakeup_at: "2021-02-10T12:00:00")

    assert !s2.valid?
    assert_equal 'sleep_at overlap', s2.errors.messages[:sleep_at].first
  end
end
