class Tagging < ActiveRecord::Base
  validates :tag, :link, :user, presence: true
  belongs_to :tag
  belongs_to :link
  belongs_to :user
end
