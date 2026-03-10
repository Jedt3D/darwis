class Session < ActiveRecord::Base
  has_many :messages, dependent: :destroy, class_name: 'Message'

  validates :name, presence: true
end
