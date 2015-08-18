class User < ActiveRecord::Base
  attr_accessible :user_answers_attributes, :twitterid, :ethnicities_text_area, :genders_text_area, :orientations_text_area

  validates :ethnicities_text_area, length: {maximum: 20}

  #validates :twitter_handle, presence: true
  validates :twitterid, presence: true

  has_many :ages, through: :user_answers,
                  source_type: "Age",
                  source: :answer

  has_many :educations, through: :user_answers,
                        source_type: "Education",
                        source: :answer

  has_many :incomes, through: :user_answers,
                     source_type: "Income",
                     source: :answer

  has_many :genders, through: :user_answers,
                    source_type: "Gender",
                    source: :answer

  has_many :orientations, through: :user_answers,
                     source_type: "Orientation",
                     source: :answer


  has_many :ethnicities, through: :user_answers,
                    source_type: "Ethnicity",
                    source: :answer

  has_many :user_answers

  accepts_nested_attributes_for :user_answers


  ################### ETHNICITY METHODS ##############################

  #returns five most common values to populate checkbox fields in user add/edit form
  def self.top_five_ethnicities
    ethnicities_array = []
    User.all.each do |u|
      # returns array of individual ethnicities arrays
      ethnicities_array << u.ethnicities
    end
    # returns an array of ethnicity objects
    ethnicities_array = ethnicities_array.flatten
    values_array = []
    ethnicities_array.each do |a|
      values_array << a.value
    end
    # returns an array of only the unique values from values_array
    unique_array = values_array.uniq
    ethnicities_hash = {}
    # returns a hash of each item in unique_array with a value representing how many times
    # the key appears in the values_array
    unique_array.each do |v|
      b = values_array.count(v)
      ethnicities_hash[v] = b
    end
    # sorts hash by value in descending order and limits the number of
    # key/value pairs to five
    ethnicities_hash = ethnicities_hash.sort_by(&:last).reverse.take(5)
    top_five_array = []
    # returns an array of only the key values of the ethnicities_hash
    ethnicities_hash.each do |k,v|
      top_five_array << k
    end
    return top_five_array
  end

  # Returns ethnicity values for this user as an Array.
  def ethnicities_as_array
    ethnicities.map do |g|
      g.value
    end
  end

  def ethnicities_text_area
    ethnicities_as_array.join("\r\n")
  end

  def ethnicities_text_area=(text_from_form_field) #pull out method body into separate private method below and then call for each setter for respecitve categories
    UserAnswer.delete_all("user_id = #{self.id} AND answer_type = 'Ethnicity'")
    users_inputs_array = text_from_form_field.split("\r\n")
    users_inputs_array.each do |e|
      if !self.ethnicities_as_array.include?(e)
        value = Ethnicity.find_or_create_by_value(e)
        UserAnswer.create({user_id: self.id, answer_id: value.id, answer_type: value.class.to_s})
      end
    end
  end

  ################### GENDER METHODS ##############################

  # Returns gender values for this user as an Array.
  def genders_as_array
    genders.map do |g|
      g.value
    end
  end

  def genders_text_area
    genders_as_array.join("\r\n")
  end

  def genders_text_area=(text_from_form_field) #pull out method body into separate private method below and then call for each setter for respecitve categories
    UserAnswer.delete_all("user_id = #{self.id} AND answer_type = 'Gender'")

    users_inputs_array = text_from_form_field.split("\r\n")

    users_inputs_array.each do |g|
      if !self.genders_as_array.include?(g)
        value = Gender.find_or_create_by_value(g)
        UserAnswer.create({user_id: self.id, answer_id: value.id, answer_type: value.class.to_s})
      end
    end
  end

  ################### ORIENTATION METHODS ##############################

  # Returns orientation values for this user as an Array.
  def orientations_as_array
    orientations.map do |g|
      g.value
    end
  end

  def orientations_text_area
    orientations_as_array.join("\r\n")
  end

  def orientations_text_area=(text_from_form_field) #pull out method body into separate private method below and then call for each setter for respecitve categories
    UserAnswer.delete_all("user_id = #{self.id} AND answer_type = 'Orientation'")

    users_inputs_array = text_from_form_field.split("\r\n")

    users_inputs_array.each do |o|
      if !self.orientations_as_array.include?(o)
        value = Orientation.find_or_create_by_value(o)
        UserAnswer.create({user_id: self.id, answer_id: value.id, answer_type: value.class.to_s})
      end
    end
  end

end
