class AddInstitutionRefToReview < ActiveRecord::Migration
  def change
    add_reference :reviews, :institution, index: true, foreign_key: true
  end
end
