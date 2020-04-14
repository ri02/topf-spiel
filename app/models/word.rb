class Word < ApplicationRecord
  belongs_to :game
  validates :text, presence: true
  validates :text, uniqueness: {scope: [:game_id]}
end
