class RemoveUserFromTaggings < ActiveRecord::Migration
  def change
    remove_reference :taggings, :user, index: true
  end
end
