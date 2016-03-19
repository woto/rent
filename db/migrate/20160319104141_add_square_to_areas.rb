class AddSquareToAreas < ActiveRecord::Migration[5.0]
  def change
    add_column :areas, :square, :float
  end
end
