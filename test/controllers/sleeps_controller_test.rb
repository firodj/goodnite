require "test_helper"

class SleepsControllerTest < ActionDispatch::IntegrationTest
  test "insert new sleep" do
    bob = users(:bob)
    post user_sleeps_path(bob.id), params: {
      sleep_at: '2022-05-06',
      wakeup_at: '2022-05-07'
    }, as: :json

    data = @response.parsed_body
    assert_response 201

    sleep_record = Sleep.find(data['id'])
    want = Time.new(2022, 5, 6, 0, 0, 0, "UTC")
    assert_equal want, sleep_record.sleep_at
  end

  test "list user sleep" do
    bob = users(:bob)
    Sleep.insert_all([
      { user_id: bob.id, sleep_at: '2023-05-02T21:00', wakeup_at: '2023-05-03T06:00' },
      { user_id: bob.id, sleep_at: '2023-05-03T22:00', wakeup_at: '2023-05-04T06:00' },
      { user_id: bob.id, sleep_at: '2023-05-01T20:00', wakeup_at: '2023-05-02T06:00' },
    ])

    get user_sleeps_path(bob.id)
    assert_response 200

    data = @response.parsed_body
    assert_equal 3, data.size
    assert_equal Time.new(2023, 5, 1, 20, 0, 0, "UTC"), data[0]['sleep_at']
    assert_equal Time.new(2023, 5, 2, 21, 0, 0, "UTC"), data[1]['sleep_at']
    assert_equal Time.new(2023, 5, 3, 22, 0, 0, "UTC"), data[2]['sleep_at']
  end
end
