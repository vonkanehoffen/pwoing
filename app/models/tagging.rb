class Tagging < ActiveRecord::Base
  attr_accessible :note_id, :tag_id
  belongs_to :note
  belongs_to :tag
end
