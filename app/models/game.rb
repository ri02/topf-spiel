class Game < ApplicationRecord
  has_many :words, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :number, presence: true , numericality: true, :inclusion => 1..10
  validates :players, presence: true, numericality: true, :inclusion => 1..20
end
