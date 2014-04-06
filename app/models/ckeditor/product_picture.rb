class Ckeditor::ProductPicture < Ckeditor::Asset
  has_attached_file :data,
                    :url  => "/ckeditor_assets/products/:id/:style_:basename.jpg",
                    :path => ":rails_root/public/ckeditor_assets/products/:id/:style_:basename.jpg",
                    :styles => { :content => ['340>', :jpg], :thumb => ['160x170>', :jpg] }

  attr_accessible :width, :height

  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end
end
