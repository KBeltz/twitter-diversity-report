class UsersController < ApplicationController
  
  before_filter :params_check, only: [:create]
  before_filter :validate_user_authorized
  before_filter :validate_if_params_matches_session, except: [:new, :create]
  
  ########### Before Filters #############
  
  # Need to build in some type of message?
  def validate_user_authorized
    if session[:screen_name] == nil
      redirect_to "/auth/twitter"
    end
  end
  
  def validate_if_params_matches_session
    if params[:screen_name].downcase != session[:screen_name].downcase
      flash[:auth_error] = "I'm sorry.  You are not signed in as #{params[:screen_name]}"
      redirect_to "/"
    end
  end
  
  def params_check
    
     
    if params["answers"]["education"] == ""
      params["answers"]["education"] = params["education1"]
    end
    
    if params["answers"]["education"] != nil
      params["answers"]["education"].downcase!
      params["answers"]["education"].strip!
    end
    
    if params["answers"]["age"].length != 4
      flash[:age_error] = "Looks like the format for your birth year was incorrect.  Please try again."
      redirect_to "/users/new"
    end 
    
  end 
    
  ########### Route Methods ##############
    
  def new
  end
  
  def create
    education, age, income = params["answers"]["education"], params["answers"]["age"], params["answers"]["income"]
    
    @user = User.find_or_create_by_twitter_handle(session[:screen_name].downcase)
      
    find_or_create_if_not_nil(education: education, age: age, income: income)
    
    if session[:searched_for] == nil
      flash[:message] = "Your information has been added to our files; Any identifying information has been encrypted."
      redirect_to "/users/#{session[:username]}"
    else
      redirect_to "/user/#{session[:searched_for]}"
    end
  end
  
  def edit
    @user = User.find_by_twitter_handle(session[:screen_name].downcase)
    @answers = return_all_user_answers(@user.id)
  end
  
  def save

  end
  
  def delete
    
  end
  
  def view
    
  end
  
  private
  
  def return_all_user_answers(id)
    answer_array = UserAnswer.where(user_id: id)
    return_answer_hash = {}
    answer_array.each do |answer|
      return_answer_hash[answer.answer_type] = answer.answer_type.constantize.find(answer.answer_id).value
    end
    return_answer_hash
  end
  
  def find_or_create_if_not_nil(variable_hash)
    variable_hash.each do |klass, value|
      if value != nil
        id = (klass.to_s.capitalize.constantize).find_or_create_by_value(value).id
        UserAnswer.create(user_id: @user.id, answer_type: klass.capitalize, answer_id: id)
      end
    end
  end
  
end