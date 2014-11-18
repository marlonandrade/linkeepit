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

  test 'should show only links for signed in user' do
    assert has_content?('duff-beer'),
      'page doesnt have duff beer link'
    assert has_content?('springfield'),
      'page doesnt have springfield city link'
    assert has_no_content?('google'),
      'page has google link'
  end
end
