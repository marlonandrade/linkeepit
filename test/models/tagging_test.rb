require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  setup do
    @tagging = Tagging.new(
      tag: tags(:cities),
      link: links(:springfield)
    )
  end

  test 'a tagging cannot be made without a tag' do
    @tagging.tag = nil
    assert_not @tagging.save, 'saved tagging without tag'
  end

  test 'a tagging cannot be made without a link' do
    @tagging.link = nil
    assert_not @tagging.save, 'saved tagging without link'
  end
end
