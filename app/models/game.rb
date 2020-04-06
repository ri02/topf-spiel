class Game < ApplicationRecord
  has_many :words
  validates :name, presence: true
  validates :number, presence: true
  validates :players, presence: true
end
