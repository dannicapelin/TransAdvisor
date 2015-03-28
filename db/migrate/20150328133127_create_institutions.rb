class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :telephone
      t.string :link

      t.timestamps null: false
    end

    change_column :reviews, :rating, :integer, null: false
  end
end
