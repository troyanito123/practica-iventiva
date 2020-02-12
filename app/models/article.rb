class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true,
            length: {minimum: 2, maximum: 150}
  validates :text, presence: true,
            length: {minimum: 2, maximum: 256 }
  validate :images_validate

  def images_validate
    # puts("IMAGES: #{images.attached?}")
    if images.attached?
      images.each do |image|
        # puts("IMAGE: #{image.content_type}")
        puts("IMAGE: #{image.filename}")
        if !image.content_type.start_with?('image')
          errors.add(:images, "The file #{image.filename} must be image file")
          # image.purge
        end
      end
    end
  end

end
