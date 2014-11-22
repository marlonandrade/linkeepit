class Tagging < ActiveRecord::Base
  validates :tag, :link,  presence: true
  belongs_to :tag
  belongs_to :link
end
