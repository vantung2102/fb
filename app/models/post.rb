class Post < ApplicationRecord
    belongs_to :user
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :comments, dependent: :destroy

    has_one_attached :image
    has_rich_text :content

    def display_image
        image.variant resize_to_limit: [500, 500]
    end
end
