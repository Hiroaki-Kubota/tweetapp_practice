# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit '/'
    assert_selector 'h2', text: 'つぶやきで、世界はつながる'
  end
end
