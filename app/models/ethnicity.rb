class Ethnicity < ActiveRecord::Base
  attr_accessible :value

  validates :value, presence: true

  has_many :user_answers, as: :answer

end
