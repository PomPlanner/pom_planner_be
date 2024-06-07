# README

PomPlanner backend api only application connects to the google api. It uses youtube api (https://www.googleapis.com/youtube/v3) and google calendar (Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS). The data on the backend for users is persisted in the users table for the front PomPlanner to retrieve, a user will then search for videos with specific parameters and that data will be retrieved from the backend for the front end to parse and use in views. The google calendar is connected in the backend so a user on the front end can add a calendar event using the video data. 

* Ruby/Rails version
ruby version 3.2.2
rails version 7.1.3.4
* System dependencies
gems, api keys, .env file with google credentials, sign up for google developers console, apis, config googleoauth 2.0.
* Configuration
rails db:create rails db:migrate
bundle install
rails s to start server or RAILS_ENV=development rails s to start in development
* Database creation
the database for users is populated when a user logs in with google, and the database for user_videos is populated when a user favorites a video from the search results. A users pom event does not persist on the PomPlanner database, that data is held on their google calendar. For future addition, I probably could add an events section on the users_show page with a link to their events once they create an event it goes to that section, I suppose then an event would have to be persisted on an events table on the PomPlanner database. 
* Database initialization
run in development mode in server
* How to run the test suite
bundle exec rspec
* Services (job queues, cache servers, search engines, etc.)
this PomPlanner application uses google calendar with scope: event api, and youtube api.
* Deployment instructions
it has not been deployed yet. But I would use Heroku.
* ...
