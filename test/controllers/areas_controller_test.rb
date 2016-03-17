require 'test_helper'

class AreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @area = areas(:one)
  end

  test "should get index" do
    get areas_url
    assert_response :success
  end

  test "should get new" do
    get new_area_url
    assert_response :success
  end

  test "should create area" do
    assert_difference('Area.count') do
      post areas_url, params: { area: { map_id: @area.map_id, ref: @area.ref, title: @area.title } }
    end

    assert_redirected_to area_path(Area.last)
  end

  test "should show area" do
    get area_url(@area)
    assert_response :success
  end

  test "should get edit" do
    get edit_area_url(@area)
    assert_response :success
  end

  test "should update area" do
    patch area_url(@area), params: { area: { map_id: @area.map_id, ref: @area.ref, title: @area.title } }
    assert_redirected_to area_path(@area)
  end

  test "should destroy area" do
    assert_difference('Area.count', -1) do
      delete area_url(@area)
    end

    assert_redirected_to areas_path
  end
end
