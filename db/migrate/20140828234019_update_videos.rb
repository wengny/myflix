class UpdateVideos < ActiveRecord::Migration
  def change
    add_column(:videos, :small_cover_url, :string)
    add_column(:videos, :large_cover_url, :string)
    remove_column(:videos, :rate, :string)
    remove_column(:videos, :url, :string)
  end
end
