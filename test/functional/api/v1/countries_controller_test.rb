require 'test_helper'

class CountriesControllerTest < ActionController::TestCase
  should_not_respond_to_actions new: :get, destroy: :get

  setup do
    @country = countries(:one)
    @controller = Api::V1::CountriesController.new
  end

  test 'should retrieve countries list' do
    get :index
    assert_response :success
    assert_not_nil assigns(:countries)
    assert @response.body == ActiveModelSerializers::SerializableResource.new(Country.all, {}).to_json
  end

  test 'should retrieve visited countries' do
    get :index, params: { visited: true }
    assert_response :success
    assert_not_nil assigns(:countries)
    assert @response.body == ActiveModelSerializers::SerializableResource.new(Country.visited, {}).to_json
  end

  test 'should create country' do
    assert_difference('Country.count') do
      post :create, params: { country: @country.attributes.merge('code' => Time.now.to_s) }
    end

    assert_response :created
    assert_serializer CountrySerializer
  end

  test 'should not create duplicate currency' do
    assert_no_difference('Currency.count') do
      post :create, params: { country: @country.attributes }
    end

    assert !assigns[:country].errors[:code].empty?
  end

  test 'should retrieve an individual county' do
    get :show, params: { id: @country.to_param }
    assert_response :success
    assert @response.body == ActiveModelSerializers::SerializableResource.new(@country, {}).to_json
  end

  test 'should update country' do
    put :update, params: { id: @country.to_param, country: @country.attributes }
    assert_response 200

    assert_serializer CountrySerializer
  end

  test 'should show visits over time' do
    get :visits_over_time
    assert_response 200
    assert @response.body == Country.visited.map { |c| c.updated_at.as_json }.to_json
  end

  test 'should show visited vs unvisited' do
    get :vs
    assert_response 200
    assert @response.body == [Country.visited.count, Country.not_visited.count].to_json
  end
end
