class Product < ActiveRecord::Base

  belongs_to :section
  belongs_to :image, :class_name => 'Ckeditor::ProductPicture', :foreign_key => :image_1_id
  belongs_to :image_2, :class_name => 'Ckeditor::ProductPicture', :foreign_key => :image_2_id
  belongs_to :image_3, :class_name => 'Ckeditor::ProductPicture', :foreign_key => :image_3_id
  belongs_to :image_4, :class_name => 'Ckeditor::ProductPicture', :foreign_key => :image_4_id
  belongs_to :image_5, :class_name => 'Ckeditor::ProductPicture', :foreign_key => :image_5_id

  attr_accessible :section_id, :image_id, :image_2_id, :image_3_id, :image_4_id, :image_5_id, :name, :title_ru, :cost, :description_ru

  extend ::I18nColumns::Model
  i18n_columns :title, :description

  def to_param
    self.name.to_s.size > 0 ? self.name : self.id
  end
end
