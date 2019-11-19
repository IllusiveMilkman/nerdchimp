require 'test_helper'

class PathsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get paths_create_url
    assert_response :success
  end

  test "should get new" do
    get paths_new_url
    assert_response :success
  end

  test "should get show" do
    get paths_show_url
    assert_response :success
  end

  test "should get update" do
    get paths_update_url
    assert_response :success
  end

  test "should get destroy" do
    get paths_destroy_url
    assert_response :success
  end

end
