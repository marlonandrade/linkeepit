require 'test_helper'

class LinksPageTest < ActionDispatch::IntegrationTest
  setup do
    visit '/'
    sign_in users(:homer)
  end

  test 'it has a list of links' do
    assert has_content?('All Links')
  end

  test 'it shows only links for signed in user' do
    assert has_selector?('.link', count: 3)
    assert has_content?('duff-beer')
    assert has_content?('fostersbeer')
    assert has_content?('springfield')
    assert has_no_content?('google')
  end

  test 'it can show only unread links' do
    click_link 'unread'

    assert has_selector?('.link', count: 1)
    assert has_content?('springfield')
    assert has_no_content?('duff-beer')
  end

  test 'it can show only read links' do
    click_link 'read'

    assert has_selector?('.link', count: 2)
    assert has_content?('duff-beer')
    assert has_no_content?('springfield')
  end

  test 'it can show all links' do
    visit links_path(read: true)

    click_link 'all'

    assert has_selector?('.link', count: 3)
    assert has_content?('duff-beer')
    assert has_content?('fostersbeer')
    assert has_content?('springfield')
  end

  test 'it allows to add a new link' do
    fill_in 'url', with: 'http://krusty-burger.com'
    click_button 'Create Link'

    assert_equal current_path, links_path

    assert_equal find_field('url').value, nil
    assert has_content?('krusty-burger')
    assert has_selector?('.link', count: 4)
  end

  test 'it allows to click a link' do
    link = find_link 'http://www.duff-beer.com'

    assert_equal link[:href], 'http://www.duff-beer.com'
    assert_equal link[:target], '_blank'
  end

  test 'it allows to mark as unread' do
    link = find('.link', text: 'http://www.duff-beer.com')
    link.click_link 'mark unread'

    link = find('.link', text: 'http://www.duff-beer.com')
    assert link.has_no_content? 'mark unread'
  end

  test 'it allows to mark as read' do
    link = find('.link', text: 'http://www.springfield-ma.gov')
    link.click_link 'mark read'

    link = find('.link', text: 'http://www.springfield-ma.gov')
    assert link.has_no_content? 'mark read'
  end

end
