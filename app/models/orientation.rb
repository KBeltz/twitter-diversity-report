class Orientation < ActiveRecord::Base
  attr_accessible :value

  validates :value, presence: true

  has_many :user_answers, as: :answer

  #returns five most common values to populate checkbox fields in user add/edit form
  def self.top_five

    query = self.select(:value).uniq
    hash_of_answers = {}
    query.each do |v|
      a = self.where(value: v.value).count
      hash_of_answers[v] = a
      # binding.pry
    end
    #binding.pry
    return hash_of_answers.sort_by(&:last).reverse.take(5)
  end
end
