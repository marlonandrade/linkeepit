class Link < ActiveRecord::Base
  validates :url, presence: true
  validates :url, uniqueness: { scope: :user }
  validates :user, presence: true
  belongs_to :user
end
