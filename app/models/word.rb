class Word < ApplicationRecord
  belongs_to :game
  validates :text, presence: true
end
