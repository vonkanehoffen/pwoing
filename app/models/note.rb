class Note < ActiveRecord::Base

  attr_accessible :content, :link, :name, :tag_names
  
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  belongs_to :user
  
  validates_presence_of :name, :content
  attr_writer :tag_names
  after_save :assign_tags
  
  def tag_names
    @tag_names || tags.map(&:name).join(' ')
  end
  
  private
  
  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\s+/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end
  
end
