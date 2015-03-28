class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.boolean :youth_friendly
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
