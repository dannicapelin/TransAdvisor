class CreateReviewsTable < ActiveRecord::Migration
  def change
    create_table :reviews_tables do |t|
      t.integer :rating
      t.boolean :youth_friendly
      t.string :title
      t.text :body
    end
  end
end
