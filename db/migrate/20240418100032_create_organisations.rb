class CreateOrganisations < ActiveRecord::Migration[7.1]
  def change
    create_table :organisations do |t|
      t.string :uuid, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :address
      t.string :country
      t.string :province
      t.string :zip
      t.string :vat_id, null: false, index: { unique: true }
      t.string :email, null: false
      t.string :segment
      t.decimal :balance, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
