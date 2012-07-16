module NotesHelper
  
  def tag_links(note)
    links = ''
    note.tags.map { |t| links += link_to( t.name, tag_name_path(t.name), :class => "tag") }
    return links.html_safe
  end
  
  def belongs_to_current_user(note)
    if note.user == current_user 
      return true
    else
      return false
    end
  end
  
end
