module ApplicationHelper
  
  def submit_button(name, options={})
    return content_tag :button, name, { :class => 'btn', :type => 'submit' }.update(options)
  end
  
end
