class Photo < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  after_commit :create_items

  def create_items
    newfile = "#{Rails.root}/data/#{self.id}#{File.extname(self.image.path)}"
    FileUtils.cp self.image.path, newfile
    Item.create_from_user_photo(self.user_id, newfile)
  end
end
