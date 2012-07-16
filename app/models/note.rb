class Note < ActiveRecord::Base

  attr_accessible :content, :link, :name, :tag_names
  
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  belongs_to :user
  
  validate :name_or_link
  
  attr_writer :tag_names
  after_save :assign_tags
  
  def tag_names
    @tag_names || tags.map(&:name).join(' ')
  end
  
  private # Everything after this is private
  
  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\s+/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end

  def name_or_link
    if(name.blank? and link.blank?)
      errors[:base] << "Your note must at least have a name or link."
    end
  end
  
end
