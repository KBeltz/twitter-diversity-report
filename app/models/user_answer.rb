class UserAnswer < ActiveRecord::Base
  attr_accessible :user_id, :answer_id, :answer_type, :value

  belongs_to :answer, polymorphic: true

  belongs_to :user

  # accepts_nested_attributes_for :answer

  def field_value
    self.answer_type
  end

  def value
    self.answer.value if self.answer
  end

  def value=(form_value)
    answer_object = self.answer_type.constantize.find_or_create_by_value(form_value)
    self.answer_id = answer_object.id
  end

  def single_answer_question?
    UserAnswer.single_answer_types.include?(self.answer_type)
  end

  def self.answer_types
    single_answer_types + multi_answer_types
  end

  def self.single_answer_types
    ["Age", "Education", "Income"]
  end

  def self.multi_answer_types
    ["Ethnicity", "Gender", "Orientation"]
  end
end
