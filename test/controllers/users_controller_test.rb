require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get users_path
    
    users = @response.parsed_body
    assert_equal 4, users.size

    assert_response :success
  end
end
