class Link < ActiveRecord::Base
  validates :url, :user, presence: true
  validates :url, uniqueness: { scope: :user }

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  scope :read,   -> { where read: true }
  scope :unread, -> { where read: false }

  def unread?
    !read?
  end
end
