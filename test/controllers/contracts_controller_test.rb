require 'test_helper'

class ContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get contracts_url
    assert_response :success
  end

  test "should get new" do
    get new_contract_url
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post contracts_url, params: { contract: { area_id: @contract.area_id, date_end: @contract.date_end, date_start: @contract.date_start, rate: @contract.rate, renter_id: @contract.renter_id, title: @contract.title } }
    end

    assert_redirected_to contract_path(Contract.last)
  end

  test "should show contract" do
    get contract_url(@contract)
    assert_response :success
  end

  test "should get edit" do
    get edit_contract_url(@contract)
    assert_response :success
  end

  test "should update contract" do
    patch contract_url(@contract), params: { contract: { area_id: @contract.area_id, date_end: @contract.date_end, date_start: @contract.date_start, rate: @contract.rate, renter_id: @contract.renter_id, title: @contract.title } }
    assert_redirected_to contract_path(@contract)
  end

  test "should destroy contract" do
    assert_difference('Contract.count', -1) do
      delete contract_url(@contract)
    end

    assert_redirected_to contracts_path
  end
end
