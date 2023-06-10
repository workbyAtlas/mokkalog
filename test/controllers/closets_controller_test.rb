require "test_helper"

class ClosetsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get closets_update_url
    assert_response :success
  end
end
