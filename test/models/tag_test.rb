require 'test_helper'

class TagTest < ActiveSupport::TestCase
  setup do
    @tag = Tag.new name: 'bars'
  end

  test 'should not save tag without name' do
    @tag.name = nil;
    assert_not @tag.save, 'saved tag without name'
  end

  test 'should not save tag with duplicate name' do
    @tag.name = tags(:beer).name
    assert_not @tag.save, 'saved tag with duplicate name'
  end

  test 'should allow to add links to tag' do
    @tag.links << Link.new(
      url: 'http://www.moes-bar.com',
      user: users(:homer)
    )
    @tag.links << Link.new(
      url: 'http://www.moes-bar.com',
      user: users(:apu)
    )

    assert @tag.save, 'didnt save tag with links'
    assert_equal @tag.links.count, 2
  end
end
