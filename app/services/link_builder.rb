class LinkBuilder
  TAGS_REGEX = /(\W|\A)(#\S*)/

  def build(params)
    url = params[:url] || ''
    tags = url.scan(TAGS_REGEX).map { |m| m.last }

    Link.new(
      url: url_for(url),
      tags: tags_for(tags)
    )
  end

  private
  def url_for(url)
    url.gsub(TAGS_REGEX, '').strip
  end

  def tags_for(tags)
    tags.map do |tag| 
      Tag.new name: tag.sub(/#/, '')
    end
  end
end
