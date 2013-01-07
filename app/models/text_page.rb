class TextPage < ActiveRecord::Base
  attr_accessible :name, :title, :body, :section_id
  belongs_to :section
end
