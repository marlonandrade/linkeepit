require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test 'should not save link without url' do
    assert_not Link.new.save, 'saved link without url'
  end

  test 'should not save link with duplicate url' do
    link = Link.new url: links(:google).url
    assert_not link.save, 'saved link with duplicated url'
  end
end
