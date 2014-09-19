class CreateVideo < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, :url, :rate
      t.text :description
      t.timestamps
    end
  end
end
