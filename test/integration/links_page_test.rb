require 'test_helper'

class LinksPageTest < ActionDispatch::IntegrationTest
  setup do
    visit '/'
    sign_in users(:homer)
  end

  test 'should have a list of links' do
    assert has_content?('All Links')
  end

  test 'should show only links for signed in user' do
    assert has_selector?('.link', count: 3)
    assert has_content?('duff-beer')
    assert has_content?('fostersbeer')
    assert has_content?('springfield')
    assert has_no_content?('google')
  end

  test 'should allow to show only unread links' do
    click_link 'unread'

    assert has_selector?('.link', count: 1)
    assert has_content?('springfield')
    assert has_no_content?('duff-beer')
  end

  test 'should allow to show only read links' do
    click_link 'read'

    assert has_selector?('.link', count: 2)
    assert has_content?('duff-beer')
    assert has_no_content?('springfield')
  end

  test 'should allow to show all links' do
    click_link 'all'

    assert has_selector?('.link', count: 3)
    assert has_content?('duff-beer')
    assert has_content?('fostersbeer')
    assert has_content?('springfield')
  end

  test 'should allow to add a new link' do
    fill_in 'url', with: 'http://krusty-burger.com'
    click_button 'Create Link'

    assert_equal current_path, links_path

    assert_equal find_field('url').value, nil
    assert has_content?('krusty-burger')
    assert has_selector?('.link', count: 4)
  end

  test 'should allow to click a link' do
    link = find_link 'http://www.duff-beer.com'

    assert_equal link[:href], 'http://www.duff-beer.com'
    assert_equal link[:target], '_blank'
  end
end
