class Account < ApplicationRecord
  validates :service, :username, presence: true
  belongs_to :user
end
