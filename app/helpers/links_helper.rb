module LinksHelper
  def link_to_toggle_read link
    link_to "mark #{link.read ? 'un' : ''}read", 
      link_path(link, link: { read: link.unread? }), 
      method: :put
  end
end
