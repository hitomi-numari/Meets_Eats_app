class Area < ApplicationRecord
  has_many :events, dependent: :destroy
end
