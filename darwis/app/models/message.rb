class Message < ActiveRecord::Base
  belongs_to :session

  validates :session, presence: true
  validates :role, presence: true, inclusion: { in: %w[user assistant] }
  validates :content, presence: true

  scope :chronological, -> { order(created_at: :asc) }
end
