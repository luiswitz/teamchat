class Team < ApplicationRecord
  belongs_to :user
  has_many :talks
  has_many :channels
  validates_presence_of :slug, :user
end
