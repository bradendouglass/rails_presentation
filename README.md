###For Prospects

* This is basically a small showcase of my abilities with Rails. It isn't complete because it 
was created today(Jan 16) but, it should be a good "off the cuff" exercise. Included below is a list of thoughts as I go through it
* Things should grow as I add features along the way
* The Thought Log is long, it is meant to be a window into how I break problems apart

###Exceptions (Things with more time I would have done)

* Testing: I really think TDD/BDD is a much better way to build things. I enjoy Cucumber/Rspec/Capybara/FactoryGirl
* Git usage: I don't work off master so I would be bouncing back and forth from a working copy
* Service layer: I have been toying with this lately over the traditional: [FMSC][1]
* HAML: I know this trips up front enders but if the app was for myself I would use it over ERB

###Thought Log

* My environment is a big deal for me:
	* most of my code is written using Vim + Tmux in a Unix/BSD environment.	
	* I try and keep a notebook as a "scratch file" for each project
* When approaching new/old RoR apps I like to begin at the Gemfile
	* For green-field I don't tinker too much, just attempt to think ahead
	* For brown-field I use it to get a feeling for where others have been during the build process
	* Starting this one I just added some front-end sugar with compass and zurb-foundation
* I generated a User model. Since there is no complexity here a simple `rails g User name:string email:...` will do
	* I know my validations so I add that in (these would be tested along with any factories)
* Run first migration with `rake db:migrate`
* I am going to have a list of users I can assign tickets to so I begin to build their Controller
* Use the `rails g controller ControllerName method` syntax
* Jump into controller and I like defining the respond_to defaults at the top then adding the respond_with(@item) to each actioncs
* Each action block will be pretty simple (read: standard)
	* We will be responding to Js for ajax and Html, no API here
* I enjoy the path helpers so I use them wherever possible (redirect_to call)
* Lots of people would use a `find_x` private method and before_filter it into certain action blocks but I don't think abstracting instance methods makes life easier in this small app
* Finished all controller actions, time to build corresponding views
* For index we will do a simple list of Users with a number of active tickets
* Since I have no tests I need to jump into a browser and see what everything looks like. Before, I will add the user route resources to routes.rb
	* Since I want the app root to be at users#index I will also add that to the routes file
* First problem: forgot to pass the user into the user_path helper in order to get to the show action, easy fix
* Our UsersController responds to js so lets make the delete call on the list of users remote and build a destroy.js.erb form
	* I think dom_id is easy to focus on so we will make each li in our index have a dom_id(user) so they are easily fadedout on the destroy action
* And another error complaining about NilClass
	* Because I have no tests I jump back into the controller and make sure show looks correct
	* Then I head to the console to make sure the exact code responds there
	* My hands created an extra def in the method declaration, easily fixed/found
* The respond_with block in destroy should take and return nothing
* Hmm, the fading out doesn't work...must be an issue with dom_id stuff. The record is deleted but the jQuery fadeOut effect isn't applied to the li element
	* Since I believe it to be a dom problem, time to open Chrome Inspector
	* Chrome says there is an issue with jQuery but I don't believe it. But rails is deleting the object so it is definitely a Js issue. Moving on for now, will fix this soon
* We will be adding users through Ajax so I need the form to hide on load until the New User link is clicked + I need to actually build the form using partials
* Finishing the html portion of create/new, realized I used a weird variable in a flash message, easily fixed
* Create redirect failed to work because of multiple redirect calls, easy fix when dealing solely with html
* Js delete is working now, there was a problem with the jQuery selector in destroy.js.erb
* scope for recent added to user model to keep the recent contacts at the top of the list
* Now that the shell of the users are done, we are going to need to build the tickets that can be assigned to users
* I created the ticket model much like the user however, forgot to send the references:user_id so will have to either manually add it to the migration or create another migration 
* Now we have an index AND a 2nd table we can use rails has_many to connect the tables through their respective model
* urgency is a range from 1..10 so lets make sure it validates as so along with being a number in general
* next stop ticket controllers, but first lets add tickets to routes as a subroute to users to get some welcome route helpers
* This controller should be sparse, we want to create tickets and that is it for now (form + new/create)
* form created, links and ticket counts showing on Users page along with a link to add a ticket to the specific user, controller time
* So form done, need to create the new action along with create to build a new ticket for a user. I will show each ticket that is assigned to a person in the show person section
* On some of the above sections, due to time constraints, I jumped around a lot and through extra code in. Now I am doing as little code as possible per idea
* Another problem has popped up, seems like the form for the new tickets model is named correctly, figuring out harder routing errors
	* Fixed, didn't pass user instance var into form, little syntax slip
* Everything works, all ticket counts on user's page is updated correctly as well
* Next up we need to see a list of open tickets on the user's show page
	* This can be as easy as an instance var in the controller. Short, one liner
	* Fiddled with column floats in the list of tickets for each user, also added another link to add a tag to the selected user
* Since tickets are something big than lets create a mailer that fires with something nice, printing the ticket description and urgency
	* However, flooding people with tickets is no good, so if the urgency is above 7 lets send them the mailer on create
	* Mailers are pretty easy, make a new method that takes a few arguments, create some instance vars, call
	* For the views, we need to add the name of the mailer to the views list. For this, it will just be a txt mailer
	* Since there is a little logic built into this, lets make the mailer call from a private method
* Back a few bullit points ago I auto hid the tickets while looking at a user; however, I was doing it on a click handler and it wouldn't work
	* I am just going to toggle the class now and "spice up" the user page a bit
	* I will add a hidden class to the users's scss file and make a simple hidden class that, when active the display = none
		* In the comment above I wrote the correct css however, in the file I didn't and it took me to searching Mozilla DN to find my css issue
		* However, I knew it was an issue with the css due to the fact that I could see the class toggling in the Chrome Dev Tools
	* For the remainder of this little experiment I am going to focus on attempting to wire backbone up to add, keep track of, and maybe view/delete tickets on the user#show page
		* There is quite a lot of Rails that I have left out, authentication specifically. However, I feel many of these "features" are best served with a gem and explaining that is boring

###Backbone.js attempt log

* Gem to help us lay the base? Yep, wired up through gemfile
	* Currently there are a couple of options in this area, I went with backbone-on-rails gem due to the documentation + I like its' simplicity
* Following along with the gem, file added and generators run to get us up and going
* The focus of backbone will be on the tickets. I already attempted to add some UX functionality but will complete it with backbone.
* This will mean that none of my ticket models will respond to html
	* To fix this I will rip out the estraneous stuff in the controller, make a respond_to block and just respond_with json for needed actions
* For the mailer, I haven't done much with it so I will keep the code there, for now, it won't do anything
* With this gem there is a simple scaffold generator that will be used to get us up and running with our tickets
* My mind tends to center around controllers in Rails so I automattically start fiddling with Backbone routers
	* I know that the tickets needs to be available under /users/:id so their will be one route to there for our router
* Next stop views, we need to tell the collection where to get the list of json items which will just be the a GET request to /tickets
* With no tests, the best way to see if this url is working, we can fire open Chrome and use a plugin for Json or app like rested or postman
* Problem found, no route defined. Well that would make sense since we nested the tickets under our users. For now lets change this to /users/:id/tickets
* Ok, so now when we nav to users/:id/tickets we get some json, just what we need
* To make my life seamingly easy, I will grab all the tickets by creating a scoped route entitled api in the rails app
* This forces me to sort the tickets before pushing them to the view by their appropriate owner which should be in the url
* For now let's add the correct url to the collection and jump back into the router to make an instance of the collection and fetch all the records
* In the router we need to fill in the index by competing the function.
	* This function will create a new instance of the view with the collection and render it to the html
	* Since the tag default in backbone is div, we are making a list so lets change it in the view to li
* While we are in the view, lets write the initialize to listen on the reset action and the render to render the collection
* Before there was a toggle ticket button, this will be ripped out because backbone isn't showing the tickets...yet
	* In this case, I will go through the Chrome Web Inspector to troubleshoot
	* Still not showing the list of tickets, presumed a route error for now but attempted with both a splat and a :



[1]: http://blog.devinterface.com/2010/06/rails-best-practices-1-fat-model-skinny-controller/
