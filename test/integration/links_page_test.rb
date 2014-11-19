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

  test 'should allow to add a new link' do
    fill_in 'Url', with: 'http://krusty-burger.com'
    click_button 'Create Link'

    assert_equal current_path, links_path

    assert_equal find_field('Url').value, nil
    assert has_content?('krusty-burger')
    assert has_selector? 'tr', 3
  end

  test 'should allow to click a link' do
    link = find_link 'http://www.duff-beer.com'

    assert_equal link[:href], 'http://www.duff-beer.com'
    assert_equal link[:target], '_blank'
  end
end
