class Link < ActiveRecord::Base
  validates :url, :user, presence: true
  validates :url, uniqueness: { scope: :user }

  belongs_to :user

  has_many :taggings
  has_many :tags, through: :taggings

  scope :read,   -> { where read: true }
  scope :unread, -> { where read: false }

  before_validation :use_existing_tags

  def unread?
    !read?
  end

  private
  def use_existing_tags
    self.taggings = []
    self.tags = self.tags.map do |tag|
      Tag.find_or_create_by name: tag.name
    end
  end
end
