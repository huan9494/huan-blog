class Category < ApplicationRecord
  def self.cache_category
    Rails.cache.fetch("category") do
     Category.order("created_at ASC").pluck(:name)
    end
  end
  def self.delete_cached_category
    Rails.cache.delete("category")
  end
end
