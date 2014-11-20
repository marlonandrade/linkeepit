require 'test_helper'

class TagTest < ActiveSupport::TestCase
  setup do
    @tag = Tag.new name: 'bars'
  end

  test 'should not save tag without name' do
    @tag.name = nil;
    assert_not @tag.save, 'saved tag without name'
  end
end
