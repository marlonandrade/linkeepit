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
    link = find('.link', text: 'duff')
    link.click_link 'mark unread'

    link = find('.link', text: 'duff')
    assert link.has_no_content? 'mark unread'
  end

  test 'it allows to mark as read' do
    link = find('.link', text: 'springfield')
    link.click_link 'mark read'

    link = find('.link', text: 'springfield')
    assert link.has_no_content? 'mark read'
  end

  test 'it show tags for each link' do
    city_link = find('.link', text: 'springfield')
    city_tags = city_link.find('.tags')

    assert city_tags.has_content? 'cities'
    assert city_tags.has_no_content? 'beer'

    duff_link = find('.link', text: 'duff')
    duff_tags = duff_link.find('.tags')

    assert duff_tags.has_content? 'beer'
    assert duff_tags.has_content? 'moes-bar'
    assert duff_tags.has_no_content? 'cities'

    foster_link = find('.link', text: 'foster')
    foster_tags = foster_link.find('.tags')

    assert_equal '', foster_tags.text
  end

  test 'it allows to add a new link with tags' do
    fill_in 'url', with: 'http://krusty-burger.com #burger #krusty #tasty #potatoes'
    click_button 'Create Link'

    assert_equal current_path, links_path

    krusty_link = find('.link', text: 'krusty')
    krusty_tags = krusty_link.find('.tags')

    assert krusty_tags.has_content? 'burger'
    assert krusty_tags.has_content? 'krusty'
    assert krusty_tags.has_content? 'tasty'
    assert krusty_tags.has_content? 'potatoes'
  end

end
