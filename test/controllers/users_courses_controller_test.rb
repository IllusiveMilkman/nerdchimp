require 'test_helper'

class UsersCoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_courses_index_url
    assert_response :success
  end

  test "should get update" do
    get users_courses_update_url
    assert_response :success
  end

  test "should get destroy" do
    get users_courses_destroy_url
    assert_response :success
  end

end
