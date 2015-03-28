class Institution < ActiveRecord::Base
  has_many :reviews, dependent: :destroy


  validates :name,
            presence: true

  validates :address,
            presence: true

  validates :telephone,
            length: { minimum: 8, maximum: 15 },
            format: {
              with: /\A[ \+\(\)\d]+\z/,
              message: 'Must be a phone number'
            }
end
