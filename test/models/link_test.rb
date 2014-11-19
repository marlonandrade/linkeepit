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
end
