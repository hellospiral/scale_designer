# Scale Designer

#### By Matt Carlson

## Description

Ruby on Rails web app for designing and saving custom musical scales in a just intonation tuning system.


## Configuration

1. `git clone https://github.com/hellospiral/scale_designer.git`
1. `cd scale_designer`
1. `bundle`
1. `rake db:create && rake db:migrate`
1. `rails s` and visit [localhost:3000](http://localhost:3000)

### Configuring 'sign in via Google' with Omniauth

1. Register the app with the [Google Developer Console](https://console.developers.google.com) to get a Client ID and Client Secret
1. Enable the Google+ API and the Contacts API in the Google Developer Console
1. Specify the redirect URI as 'http://localhost:3000/users/auth/google_oauth2/callback'
1. In the root directory of the repo, create a .env file
1. Inside of .env, add `CLIENT_ID=[your client id]
CLIENT_SECRET=[your client secret]`


## Technologies Used

* Ruby
* Rails
* Javascript
* Web Audio API
* AJAX
* Devise
* Omniauth
* Bootstrap
* CSS
* HTML
* Rspec
* Capybara

### License

This software is licensed under the MIT license.

Copyright (c) 2016 Matt Carlson
