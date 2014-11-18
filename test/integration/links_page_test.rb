require 'test_helper'

class LinksPageTest < ActionDispatch::IntegrationTest
  setup do
    visit '/'
    sign_in users(:homer)
  end

  test 'should have a list of links' do
    assert has_content?('All Links'), 
      'page doesnt have a All Links title'
  end
end
