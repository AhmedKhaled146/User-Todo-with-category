require "test_helper"

class CategoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get category_index_url
    assert_response :success
  end

  test "should get show" do
    get category_show_url
    assert_response :success
  end

  test "should get update" do
    get category_update_url
    assert_response :success
  end

  test "should get delete" do
    get category_delete_url
    assert_response :success
  end
end
