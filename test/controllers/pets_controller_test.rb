require 'test_helper'

class PetsControllerTest < ActionController::TestCase

  # Necessary setup to allow ensure we support the API JSON type
  setup do
     @request.headers['Accept'] = Mime::JSON
     @request.headers['Content-Type'] = Mime::JSON.to_s
   end

  test "can get #index" do
    get :index
    assert_response :success
  end

  test "#index returns json" do
    get :index
    assert_match 'application/json', response.header['Content-Type']
  end

  test "#index returns an Array of Pet objects" do
    get :index
    # Assign the result of the response from the controller action
    body = JSON.parse(response.body)
    assert_instance_of Array, body
  end

  test "returns three pet objects" do
    get :index
    body = JSON.parse(response.body)
    assert_equal 3, body.length
  end

  test "each pet object contains the relevant keys" do
    keys = %w( age human id name )
    get :index
    body = JSON.parse(response.body)
    assert_equal keys, body.map(&:keys).flatten.uniq.sort
  end

  test "if a specific pet is shown correctly" do
    get :show, {id: pets(:one)}
    body = JSON.parse(response.body)
    assert_equal body["name"], "Peanut"
  end

  test "if a pet is not in the database, an empty array is returned" do
    get :show, {id: 100}
    body = JSON.parse(response.body)
    assert_empty body
    assert_response :no_content
  end

  test "can get #show" do
    get :show, {id: pets(:one)}
    assert_response :ok
    #use "ok" instead of "success" because any response is success even if the pet is not in the database, or even 404 would also be considered as "success"
  end

end
