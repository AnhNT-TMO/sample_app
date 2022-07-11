class Micropost < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  CREATEABLE_ATTR = %i(content image).freeze

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.max_length}
  validates :image, content_type: {in: Settings.micropost.image_path,
                                   message: :wrong_format},
    size: {less_than: Settings.micropost.less_than.megabytes,
           message: :too_big}

  delegate :name, to: :user, prefix: true
  scope :newest, ->{order created_at: :desc}
  scope :by_user_ids, ->(user_id){where user_id: user_id}

  def display_image
    image.variant resize_to_limit: Settings.micropost.resize_to_limit
  end
end
