class Education < ActiveRecord::Base
  attr_accessible :level_attained
  
  validates :level_attained, presence: true
  validates :level_attained, uniqueness: {case_sensitive: false}
  
  has_many :user_answers, as: :answer
end
