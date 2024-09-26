class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :vendor, null: false, foreign_key: {to_table: :vendors}
      t.references :sender, null: false, foreign_key: { to_table: :organisations }
      t.references :receiver, null: false, foreign_key: { to_table: :organisations }
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
