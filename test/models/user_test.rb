require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user can list all tags he made' do
    homer = users :homer
    assert homer.tags.include? tags(:cities)
    assert homer.tags.include? tags(:beer)

    apu = users :apu
    assert apu.tags.include? tags(:beer)
    assert_not apu.tags.include? tags(:cities)
  end
end
