class Link < ActiveRecord::Base
  validates :url, :user, presence: true
  validates :url, uniqueness: { scope: :user }
  belongs_to :user
end
