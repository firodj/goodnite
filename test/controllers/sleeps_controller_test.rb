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
    want = Time.new(2022, 5, 6, 0,0,0, "UTC")
    assert_equal want, sleep_record.sleep_at
  end
end
