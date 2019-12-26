class Company < ApplicationRecord
  validate :title, presence: true
end
