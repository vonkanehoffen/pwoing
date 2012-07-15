module NotesHelper
  
  def tag_links(note)
    links = ''
    note.tags.map { |t| links += link_to( t.name, tag_name_path(t.name), :class => "tag") }
    return links.html_safe
  end
  
end
