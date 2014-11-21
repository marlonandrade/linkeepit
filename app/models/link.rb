class Link < ActiveRecord::Base
  validates :url, :user, presence: true
  validates :url, uniqueness: { scope: :user }

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  before_validation :set_user_for_tagging

  scope :read,   -> { where read: true }
  scope :unread, -> { where read: false }

  def unread?
    !read?
  end

  private
  def set_user_for_tagging
    taggings.each do |tagging|
      tagging.user = user
    end
  end
end
