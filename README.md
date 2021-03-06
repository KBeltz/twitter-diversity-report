<a name="greeting"></a>
# Twitter Diversity Report

04/14/2015
Version 1.0

Welcome to our repository! This is an open-source project that originated as a group project for the  [Omaha Code School](http://www.omahacodeschool.com) Spring 2015 class.

**If you're here to submit feedback on the website, [please submit a new Issue](https://github.com/omahacodeschool/twitter-diversity-report/issues).** _Please know that if you do not already have a Github account, you will be prompted to sign up. If you don't wish to do so, you can always reach out to us on Twitter._

- Andrew Strovers  -  [GitHub](http://github.com/ADStrovers)  -   [@MidwestBoardGam](http://twitter.com/midwestboardgam)
- Alexandra Millatmal  -  [GitHub](http://github.com/halfghaninne)  -   [@halfghaninNE](http://twitter.com/halfghaninne)
- Crystal Cooling  -  [GitHub](http://github.com/coolingcza)  -  [@cza_dev](http://twitter.com/cza_dev)
- Hilary Stohs-Krause  -  [GitHub](http://github.com/hilarysk)  -  [@hilarysk](http://twitter.com/hilarysk)

If you'd like to contribute to the project, read on!

[How To Contribute](#contribute)
* [Fork and Clone the Repository](#clone)
* [Prepare Your Local Environment](#localenv)
* [Get an API Key](#apikey)<br>

[More About the Twitter API](#more)<br>
[Sitemap](#sitemap)<br>
[Original Project Specs/User Story](#specs)<br>


---

<a name="contribute"></a>
#To Contribute

<a name="clone"></a>
##Fork and Clone the Project

1. [Fork this repository]( https://github.com/omahacodeschool/twitter-diversity-report/fork )

2. In your parent folder in Terminal, copy the SSH clone URL (located in the right-hand column of this screen).
    
    This will create a project folder called **twitter-diversity-report** that is intialized to your forked repository.
    
    ![alt text](http://i.imgur.com/oFbi7Y9.gif "how to clone the repository")
    
3. [Prepare your local environment](#localenv) and [get a Twitter API key](#apikey) before starting to develop!
4. In your local project folder, create a branch for the features you want to work on (`git checkout -b my-new-feature`)
5. Commit changes as you go (`git commit -am 'Add some feature'`) and push commits to that branch (`git push origin my-new-feature`)

6. When you're finished, create a new Pull Request for us to review.

<a name="localenv"></a>
##Prepare Your Local Environment

This program was built with Ruby on Rails 3.2.21. **Please ensure that you have at least this version of Rails**, as some methods may not be available in other versions.

Next:

* **Install gems** included in the Gemfile you just cloned by running `bundle install` in Terminal.

* **Prepare your local database.** This application relies on users providing information to our database, and checks a given user's Twitter 'friends' against the records in that database. Our seed file contains dummy information for our team members. 
  * Run `rake db:migrate` to set up your local database structure
  * Run `rake db:seed` to populate the database with our dummy information
  * Follow any/all of us on Twitter! [Here](http://twitter.com/midwestboardgam), [here](http://twitter.com/halfghaninne), [here](http://twitter.com/cza_dev), or [here](http://twitter.com/hilarysk). This:
    * Ensures that if you search for yourself, our records in the database will be associated with your 'friends' return from Twitter
	* Allows you to be more readily in contact with us if you have questions about our code.
	* Is awesome because we would love to meet you!

* **Create an .env file.** This is a file that will be specific to your local environment and contains sensitive API information, accessed throughout the rest of the code. It is [referenced](https://github.com/omahacodeschool/twitter-diversity-report/blob/master/.gitignore#L18) in this project's **.gitignore** file, which means it's ignored when you push updates to your own Github repository -- no API keys out in the wild!

  * In Terminal, in the parent project folder, create the file with `touch .env`

  * Open the file with `mate .env` 


<a name="apikey"></a>
##Get an API Key

* Using your personal Twitter account, [register a new application](https://apps.twitter.com/app/new) to access API credentials for Twitter.
	
	These applications allow you free access to the Twitter API and are meant for development purposes. As such they do have usage limits, which you can [read about here](https://dev.twitter.com/rest/public/rate-limiting).

* The registration process will prompt you for details about your new app, including a name for the application, description, and website. These can be filler information.

* The form will also ask you for a Callback URL. **In order for Twitter authentication to redirect to the correct path in the application** during local development, the Callback URL **must be:** `http://127.0.0.1:3000/auth/twitter/callback` 

* Once you've registered your application, you will be able to access its API keys under Keys and Access Tokens. You will use two seperate keys for this application, the **Consumer Key (API Key)** and the **Consumer Secret (API Secret)**.
	
	![alt text](http://i.imgur.com/I5otjKT.jpg "get api keys")
	
	In your **.env** file, set those keys equal to the variables `public` and `secret`, like so:

	```
	public =  _[Consumer Key (API Key)]_
	secret = _[Consumer Secret (API Secret)]_
	```
	
	These variables are referenced throughout the program to call on the Twitter API without revealing your sensitive API information.

* When someone using the Twitter Diversity web app authorizes it to authenticate with their Twitter account, they see a variety of permissions they will be granting the app. 
	
	We initially wrote this application with a Read Only permission, but if you want to develop a great new feature (say something that allows Twitter users to tweet from the site) you might use a different permission.
	
	You can change Permissions for the application in its settings:
	
	![alt text](http://i.imgur.com/jqIVBfF.gif "change app permissions")
  


---

<a name="more"></a>
# More About the Twitter API

The Ruby interface for the Twitter API is [extensively documented](https://github.com/sferik/twitter), as is the [API itself](https://dev.twitter.com/rest/public). 

Below are the calls that we used in our application and any helpful advice we figured out along the way:

`Twitter::REST::Client.new` [makes a new request](https://github.com/omahacodeschool/twitter-diversity-report/blob/master/app/models/result.rb#L9-L14) to the Twitter client using the access keys you establish in your local **.env** file. If the keys are accurate and the configuration is successful, this give us access to make further calls to the API. 

On the `client` configured above, you can call a variety of functions. We [exclusively used](https://github.com/omahacodeschool/twitter-diversity-report/blob/master/app/models/result.rb#L19) `client.friend_ids(searched_twitter_handle)` which instructed the call to read through the 'friends' return for a searched for Twitter user, specifically reading/returning their Twitter IDs. IDs are a faster search for the API, and this search returns more information per search than does a search for user names. This is important when considering the API's usage limits.


---

<a name="sitemap"></a>
#Sitemap

![alt text](http://i.imgur.com/8bzl2of.jpg "sitemap")

---

<a name="specs"></a>
# Project Specs / User Story

The web application allows a user to search for a Twitter account, and then provides the user with demographic insights of people/accounts that account follows. 

To accomplish this, the program has two main pieces of functionality: **Self-identifying** -- A way for people to indicate their Twitter username and volunteer and self-define their personal demographic information; **Reporting** -- A way for a person to visit the site and get a report of the demographics of the people they follow on Twitter.

## Self-identifying

The story goes like this:

1. I go to the website and click a link to add my personal demographic information.
2. I'm redirected to Twitter, where I need to log in.
3. Upon logging into Twitter, I'm sent back to the website. The website now knows what my Twitter username is -- and it knows that I am the owner of that username, because I logged in on Twitter.
4. I see a form with questions for things like sexual orientation, gender, race, place of residence, age, visual ability, etc. All of the questions are optional and free-form text entry.
5. I type my identity for some/all questions and submit the form.
6. The application records my answers and associates them with my Twitter username.

##  Reporting

The story goes like this:

1. I go to the website and click a link to get a diversity report for some Twitter user.
2. I'm presented with a form, into which I type a Twitter username. Then I submit the form.
3. I'm presented with a message that says the report is being generated. In the meantime, would I please add my own demographic information?
  - If I decide to acquiesce, I go through a similar story as described above in _Self-identifying_. The major difference is that when I finish submitting my demographic information, I'm thanked and continue from the next step in _this_ story.
  - If I decide not to provide my own demographic information, I click a link to decline.
4. I'm presented with a report that is associated with the requested Twitter user. The data itself for the report has been stored in the database.
  - The report shows a basic pie chart for each demographic question.
  - The data draws from self-reported identity information. So the more people that do the _Self-identifying_ task described above, the better reports in general will be.
  - Running a report for the same user in the future will likely yield different data -- either because that user has since changed the people whom they follow, or because more of the user's followers have since added their demographic information.
