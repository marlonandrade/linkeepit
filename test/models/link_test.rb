require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  setup do
    @link = Link.new(
      url: 'http://kwik-e-mart.com',
      user: users(:apu)
    )
  end

  test 'should not save link without url' do
    @link.url = nil;
    assert_not @link.save, 'saved link without url'
  end

  test 'should not save link with duplicate url for same user' do
    @link.url = links(:springfield).url
    @link.user = users(:homer)
    assert_not @link.save, 'saved link with duplicated url'
  end

  test 'should save link with duplicate url for different user' do
    @link.url = links(:springfield).url
    assert @link.save, 'didnt save link with duplicate url but for different user'
  end

  test 'should not save link without user' do
    @link.user = nil
    assert_not @link.save, 'saved link without user'
  end

  test 'should allow to add tags to link' do
    @link.tags << Tag.new(name: 'market')
    @link.tags << Tag.new(name: 'store')

    assert @link.save, 'didnt save link with tags'
    assert_equal @link.tags.count, 2
  end

  test 'a new link defaults to false' do
    link = Link.create url: 'http://matt-groening.com'
    assert_not link.read?
  end

  test 'links can be filtered by read status' do
    chars = ['homer', 'bart', 'marge', 'lisa']
    chars.each do |char|
      Link.create(
        url: "http://www.simpsons.com/#{char}",
        read: true,
        user: users(:homer)
      )
    end

    assert_equal 5, Link.read.count
    assert_equal 2, Link.unread.count
  end
end
