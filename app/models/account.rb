class Account < ApplicationRecord
  validates :service, :username, presence: true
end
