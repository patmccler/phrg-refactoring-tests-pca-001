# frozen_string_literal: true

class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w[Fiction Non-Fiction] }
  validate :clickbait?

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top [0-9]*/i,
    /Guess/i,
  ].freeze

  def clickbait?
    return unless CLICKBAIT_PATTERNS.none? { |pat| pat.match title }

    errors.add(:title, "must be clickbait")
  end
end
