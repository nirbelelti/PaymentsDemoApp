class CreateOrganisations < ActiveRecord::Migration[7.1]
  def change
    create_table :organisations do |t|
      t.string :name
      t.integer :crm_id
      t.string :address
      t.string :country
      t.string :province
      t.string :zip
      t.string :vat_id
      t.string :email
      t.string :segment

      t.timestamps
    end
  end
end
