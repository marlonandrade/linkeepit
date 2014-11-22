class LinkBuilderTest < ActiveSupport::TestCase
  setup do
    @builder = LinkBuilder.new
  end

  test 'should parse a simple url' do
    params = {
      url: 'http://duff-beer.com'
    }

    link = @builder.build params

    assert_not_nil link
    assert_equal link.url, 'http://duff-beer.com'
    assert_empty link.tags
  end

  test 'should trim the url' do
    params = {
      url: '    http://duff-beer.com   '
    }

    link = @builder.build params

    assert_not_nil link
    assert_equal 'http://duff-beer.com', link.url
    assert_empty link.tags
  end

  test 'should get single tag from url' do
    params = {
      url: 'http://duff-beer.com #beer'
    }

    link = @builder.build params

    assert_not_nil link
    assert_equal 'http://duff-beer.com', link.url
    assert link.tags.map(&:name).include? 'beer'
  end

  test 'should get multiple tags from url' do
    params = {
      url: 'http://duff-beer.com #beer #burp #moes'
    }

    link = @builder.build params

    assert_not_nil link
    assert_equal 'http://duff-beer.com', link.url
    assert_equal 3, link.tags.length

    tag_names = link.tags.map &:name
    assert tag_names.include? 'beer'
    assert tag_names.include? 'burp'
    assert tag_names.include? 'moes'
  end

  test 'should get tags even if it has dots' do
    params = {
      url: 'http://duff-beer.com #beer.good #moes-bar'
    }

    link = @builder.build params

    assert_not_nil link
    assert_equal 'http://duff-beer.com', link.url
    assert_equal 2, link.tags.length

    tag_names = link.tags.map &:name
    assert tag_names.include? 'beer.good'
    assert tag_names.include? 'moes-bar'
  end

  test 'should allow the tag to be in any position' do
    params = {
      url: '#beer #moes http://duff-beer.com #good'
    }

    link = @builder.build params

    assert_not_nil link
    assert_equal 'http://duff-beer.com', link.url
    assert_equal 3, link.tags.length

    tag_names = link.tags.map &:name
    assert tag_names.include? 'beer'
    assert tag_names.include? 'moes'
    assert tag_names.include? 'good'
  end
end
