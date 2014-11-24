class AddUniqIndexToTags < ActiveRecord::Migration
  def change
    Tagging.all.each do |tagging|
      tagging.tag = Tag.
        where(name: tagging.tag.name).
        order(created_at: :asc).
        first
      tagging.save
    end

    Tag.all.each do |tag|
      tag.destroy unless tag.taggings.present?
    end

    remove_index :tags, :name
    add_index :tags, :name, unique: true
  end
end
