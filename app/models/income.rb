class Income < ActiveRecord::Base
  attr_accessible :value
  
  validates :value, presence: true
  validates :value, uniqueness:  {case_sensitive: false}
  validates :value, numericality: {only_integer: true}  
 
  has_many :user_answers, as: :answer
    
end
