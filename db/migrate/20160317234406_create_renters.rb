class CreateRenters < ActiveRecord::Migration[5.0]
  def change
    create_table :renters do |t|
      t.string :title
      t.float :account, default: 0

      t.timestamps
    end
  end
end
