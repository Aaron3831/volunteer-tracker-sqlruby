# _to-do_

##### This application is a demonstration application designed to show classes, tests, views with Sinatra and SQL (no Active Record).

## Technologies Used

Application: Ruby, Sinatra<br>
Testing: Rspec, Capybara<br>
Database: Postgres

Installation
------------

Install Volunteer Tracker by first cloning the repository.  
```
$ git clone https://github.com/Aaron3831/volunteer-tracker-sqlruby.git
```

Install required gems:

Gemfile <

source('https://rubygems.org')

gem('rspec')
gem('sinatra')
gem('sinatra-contrib')
gem('pry')
gem('capybara')
gem('pg')
```
$ bundle install
```

```
In PSQL:
CREATE DATABASE to_do;
CREATE TABLE projects (id serial PRIMARY KEY, name varchar);
CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar, project_id int);
```

Start the webserver:
```
$ ruby app.rb
```

Navigate to `localhost:4567` in browser.

License
-------

GNU GPL v2. Copyright 2017 **Aaron Nguyen**
