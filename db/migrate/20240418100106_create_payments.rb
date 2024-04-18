class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :organisation, null: false, foreign_key: true
      t.integer :sender_id
      t.integer :receiver_id
      t.float :amount

      t.timestamps
    end
  end
end
