class User < ApplicationRecord
    has_many :participants, dependent: :destroy
    has_many :rounds, dependent: :destroy
    has_many :participating_rounds, through: :participants, source: :round
end
  