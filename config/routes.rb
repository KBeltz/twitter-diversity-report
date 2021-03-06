TwitterDiversity::Application.routes.draw do
    
  ########### PUBLIC ############################
  
  get "/" => 'public#home' #if they click search, sends that name to post:results
  
  ########## USERS ##############################
    
  post "/logout" => 'users#logout', as: :logout
  
  get "/users/:screen_name/edit" => 'users#edit' #protected
  
  put "/users/:id" => 'users#save', as: :user
  
  delete "/users/:id" => 'users#delete' #protected
   
  get "/users/:id" => 'users#view' #protected
  
  ########## RESULTS ###########################
  
  get "/current" => 'results#current'
  
  get "/current/:screen_name" => 'results#current' #redirects to /:id
  
  get "/results/:id" => 'results#view' #pulls from results table
  
  post "/results" => 'results#create' #generates results record to populate /:id, make sure to clear session after this loads
  
  get "/reroute" => 'results#reroute' #TODO would like to change to a post route
  
  ######### OMNIAUTH ###########################
  
  get "/auth/twitter/callback" => "public#return"

  get "/auth/failure" => "public#failure"
  
  ######### BAD USER ENTRY REROUTING ###########
  
  get "/:screen_name" => 'results#current'
end
