class ResultsController < ApplicationController
  

  def current

    @twitter_handle = params[:screen_name]
    
    client = Result.client
    
    demo_hash = Result.build_result_hash(client, @twitter_handle)

    result = Result.create(searched_handle: @twitter_handle,
                        demo_hash: demo_hash)
    
    redirect_to "/results/#{result.id}"
  end

  def create
    client = Result.client
    @twitter_handle = params[:searched_twitter_handle]

    binding.pry

    demo_hash = Result.build_result_hash2(client, @twitter_handle)

    binding.pry

    result = Result.create(searched_handle: @twitter_handle,
                        demo_hash: demo_hash)

    redirect_to "/results/#{result.id}"

  end
 

  def view
    session[:searched_twitter_handle] = nil
    @result = Result.find(params[:id])  

  end
  
end
