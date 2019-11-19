require 'test_helper'

class UsersCoursesPathsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_courses_paths_index_url
    assert_response :success
  end

  test "should get create" do
    get users_courses_paths_create_url
    assert_response :success
  end

  test "should get new" do
    get users_courses_paths_new_url
    assert_response :success
  end

  test "should get edit" do
    get users_courses_paths_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_courses_paths_update_url
    assert_response :success
  end

  test "should get destroy" do
    get users_courses_paths_destroy_url
    assert_response :success
  end

end
