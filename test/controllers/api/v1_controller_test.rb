require "test_helper"

class Api::V1ControllerTest < ActionDispatch::IntegrationTest
  test "should get words" do
    get api_v1_words_url
    assert_response :success
  end
end
