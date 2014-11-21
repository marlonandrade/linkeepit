class Tag < ActiveRecord::Base
  validates :name, presence: true
  has_many :taggings
  has_many :links, through: :taggings

  before_validation :set_link_user_for_tagging

  private
  def set_link_user_for_tagging
    taggings.each do |tagging|
      tagging.user = tagging.link.user
    end
  end
end
