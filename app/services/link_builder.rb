class LinkBuilder
  def build(params)
    url = params[:url] || ''
    tags = url.scan(/#\S*/)

    Link.new(
      url: url_for(url),
      tags: tags_for(tags)
    )
  end

  private
  def url_for(url)
    url.gsub(/#\S*/, '').strip
  end

  def tags_for(tags)
    tags.map do |tag| 
      Tag.new name: tag.sub(/#/, '')
    end
  end
end
