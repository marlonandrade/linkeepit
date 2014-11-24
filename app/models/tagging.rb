class Tagging < ActiveRecord::Base
  validates :tag, :link, presence: true

  belongs_to :tag, inverse_of: :taggings
  belongs_to :link
end
