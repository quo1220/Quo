require 'test_helper'

class SuggestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get suggests_index_url
    assert_response :success
  end

end
