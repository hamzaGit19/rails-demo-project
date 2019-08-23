# frozen_string_literal: true

require 'test_helper'

class Api::V1ControllerTest < ActionDispatch::IntegrationTest
  test 'should get users' do
    get api_v1_users_url
    assert_response :success
  end
end
