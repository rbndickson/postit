module Voteable
  extend ActiveSupport::Concern

  included do # this is for class methods
    has_many :votes, as: :votable
  end

  # these are instance methods

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end
end
