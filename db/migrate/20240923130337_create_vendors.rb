class CreateVendors < ActiveRecord::Migration[7.1]
  def change
    create_table :vendors do |t|
      t.string :name, null: false
      t.string :uuid, null: false, index: { unique: true }
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
