class CreateMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :maps do |t|
      t.string :title
      t.string :map
      t.string :dashboard_map

      t.timestamps
    end
  end
end
