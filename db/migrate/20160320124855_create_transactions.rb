class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :contract_string
      t.string :renter_string
      t.string :area_string
      t.references :contract, foreign_key: true
      t.references :renter, foreign_key: true
      t.references :area, foreign_key: true
      t.float :amount
      t.float :account_were
      t.float :account

      t.timestamps
    end
  end
end
