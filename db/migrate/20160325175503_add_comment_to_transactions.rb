class AddCommentToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :comment, :text
  end
end
