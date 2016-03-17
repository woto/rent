require 'test_helper'

class RentersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @renter = renters(:one)
  end

  test "should get index" do
    get renters_url
    assert_response :success
  end

  test "should get new" do
    get new_renter_url
    assert_response :success
  end

  test "should create renter" do
    assert_difference('Renter.count') do
      post renters_url, params: { renter: { account: @renter.account, date_end: @renter.date_end, date_start: @renter.date_start, rate: @renter.rate, title: @renter.title } }
    end

    assert_redirected_to renter_path(Renter.last)
  end

  test "should show renter" do
    get renter_url(@renter)
    assert_response :success
  end

  test "should get edit" do
    get edit_renter_url(@renter)
    assert_response :success
  end

  test "should update renter" do
    patch renter_url(@renter), params: { renter: { account: @renter.account, date_end: @renter.date_end, date_start: @renter.date_start, rate: @renter.rate, title: @renter.title } }
    assert_redirected_to renter_path(@renter)
  end

  test "should destroy renter" do
    assert_difference('Renter.count', -1) do
      delete renter_url(@renter)
    end

    assert_redirected_to renters_path
  end
end
