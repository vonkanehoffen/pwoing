class Note < ActiveRecord::Base

  attr_accessible :content, :link, :title, :tag_names
  
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  belongs_to :user
  
  validate :title_or_link
  before_save :sanitise_link
  
  attr_writer :tag_names
  after_save :assign_tags
  
  def tag_names
    @tag_names || tags.map(&:name).join(' ')
  end
  
  def sanitise_link
    # Maybe we should validate a bit more in the controller
    if !self.link.blank?
      if !self.link.start_with?("http://","https://","ftp://")
        if self.link.start_with?("//")
          self.link.insert(0,"http:")
        else
          self.link.insert(0,"http://")
        end
      end
    end
  end
  
  def self.search_by_tag(tag)
    if tag
      # create plural and non-plural version of the tag
      tag.downcase!
      tag.strip!
      tag_alt = if tag.end_with?('s') then tag[0..-2] else tag+'s' end
      joins(:tags).where("lower(name) = ? OR lower(name) = ?", tag, tag_alt).order("created_at DESC")
    end
  end
  
  private # Everything after this is private
  
  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\s+/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end

  def title_or_link
    if(title.blank? and link.blank?)
      errors[:base] << "Your note must at least have a title or link."
    end
  end
  
end
