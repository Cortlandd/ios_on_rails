# iOS on Rails - Part I

This guide assumes that you already have a Ruby on Rails environment. We will also assume that you are using **Rails 4.0.2** and at least **Ruby 1.9.3**. This is just a "getting started" tutorial and there are many aspects of a Rails application that will not be covered.

## Get to know the tools

Here is the list of preferred software for this workshop:

* **Text editor** — Sublime Text ([http://www.sublimetext.com/2](http://www.sublimetext.com/2))

* **Terminal** — Where you start the Rails server and run commands. You must get used to terminal (or you can use iTerm instead).

* **Web browser** — Your backoffice will be visible on one of these. Preferably Chrome.

## Rails MVC

Before moving forward it's important that you get used to Rails architecture. [MVC](http://en.wikipedia.org/wiki/Model%E2%80%93View%E2%80%93Controller) is a software architecture, or a pattern used in software engineering, seeking to separate content, presentation, and behavior.

![](https://github.com/marcric/ror3gangsclock/wiki/general_mvc.png)

#### Controllers

Controllers are the conductors of an MVC application they are in the front line accepting requests from the outside world, meaning user input.

They perform the necessary processing, call the appropriate functions on model objects if necessary, and through the actions that live inside it, passes control to the view layer to render the results in whatever format you want.

In Rails **Action Controller** does most of the groundwork for you and uses smart conventions to make everything as straightforward as possible.

#### Views

Views are responsible for the visible part of the application or what the user actually sees. It can be HTML markup to be displayed in a browser but could be XML, JavaScript, JSON, or any other.

#### Models

Models are the representation of the objects (users, personal data, friendships, etc.), involved in the application so called "business logic".
While we call the entire layer "the model", Rails applications are usually made up of several individual models, each of which (usually) maps to a database table.

In Rails the models are all descendants of **Active Record**. Active Record facilitates the creation and use of business objects whose data requires persistent storage to a database. It is an implementation of the Active Record pattern which itself is a description of an Object Relational Mapping (ORM) system.

## Creating the application

Today we will be creating a simple web application for you to manage your daily tasks and your TODO list. This application will be able to support different users, having each one its own set of tasks.

You can call it whatever you want but from now on we will call it `todo`.

First open your terminal type the `rails new` command to create your new project and change current directory:

```
$ rails new todo
$ cd todo
```

If you `ls` on the newly created project you can see that Rails creates a lot of files and directories for you. Ruby on Rails follows a philosophy of **convention over configuration** so every piece of code you'll code it's a change do the default Rails behaviour rather than a configuration of a new project.

Here's a short list of the directories and files of most importance:

| File/Folder | Purpose                                                       |
| ------------|---------------------------------------------------------------|
| app/        | Contains the controllers, models, views, helpers, mailers and assets for your application. You'll focus on this folder for the remainder of this guide. |
| bin/        | Contains the rails script that starts your app and can contain other scripts you use to deploy or run your application. |
| config/ | Configure your application's runtime rules, routes, database, and more. |
| db/ | Contains your current database schema, as well as the database migrations. |
| Gemfile Gemfile.lock | These files allow you to specify what gem dependencies are needed for your Rails application. These files are used by the Bundler gem. For more information about Bundler, see the [Bundler website](http://gembundler.com/) |
| lib/ | Extended modules for your application. |
| log/ | Application log files. |
| public/ | The only folder seen to the world as-is. Contains the static files and compiled assets. |
| Rakefile | This file locates and loads tasks that can be run from the command line. The task definitions are defined throughout the components of Rails. Rather than changing Rakefile, you should add your own tasks by adding files to the lib/tasks directory of your application. |
| test/ | Unit tests, fixtures, and other test apparatus. |
| tmp/ | Temporary files (like cache, pid and session files)
| vendor/ | A place for all third-party code. In a typical Rails application, this includes Ruby Gems and the Rails source code (if you optionally install it into your project). |

Your application is ready to run as soon as you create it! Type `rails server`. This will fire up WEBrick which is the default Rails web server and runs on port 3000. You can open `http://localhost:3000` and check that the server is running and serving your `todo` application!

You should see the default "Welcome aboard" page. You can stop the server now (`ctrl+C` on the terminal). We just have to customize the behaviour of that default application.

## Changing the default behaviour

We will be using the `rails` command a lot. If you want type `rails` with no arguments inside your application to check what you can do. Go ahead and type `rails generate`. This command is used to generate different things like controllers, models, etc.

> **Note**: every command has a shortcut. `rails generate` can be written as `rails g`, `rails server` can be written as `rails s` and so on.

Let's add a simple view changing that welcome screen to something different. You can see that on `app/controllers` you already have an `application_controller.rb`. Every controller that you add will inherit from this one.

Create a new controller for the welcome screen:

```
rails g controller welcome index
```

We are telling Rails to generate a new controller called **WelcomeController** and having only an **index** action.

Rails controllers will have the default **CRUD** actions:

* **C**reate — `create` action
* **R**ead — `show` action
* **U**pdate — `update` action
* **D**elete — `destroy` action

The file — `welcome_controller.rb` is living under `app/controllers/`. You should have this content:

```ruby
class WelcomeController < ApplicationController
  def index
  end
end
```

> **Note**: you should be aware of the Rails conventions. One of them is that the file names should have "snake_case_names" that match "CamelCaseNames" classes.

So we created the class `WelcomeController` that inherits from `ApplicationController` (the use of `<` denotes that `ApplicationController` is the superclass of `WelcomeController`). Inside we only have one method called `index` which is empty.

You can now open the `config/routes.rb` file, where you can define which URLs will be available on your application. The file has a lot of examples but no routes configured yet. Edit the file to add a "root" url (the one that will be seen when you go to `localhost:3000/`):

```ruby
Todo::Application.routes.draw do
  root 'welcome#index'
end
```

Now we told Rails that our newly created **WelcomeController#index** is the root method that should be called.

> **Note**: in Ruby it's common to see the `<Class>#<method>` notation and in routes we use a similar notation when configuring which controller and which method should be called.

Fire up your WEBrick again and if you go to your localhost address you should see the default view for that method. It tells you can find the view in  `app/views/welcome/index.html.erb`.

Rails always tries to use the `<method>.html.erb` on the correct directory if you don't tell otherwise. When we generated the controller the command also generated this file for you.

The `.erb` extension is because Rails uses **Embedded RuBy** as the default templating system for HTML output. We won't be playing much with ERB since the application will use JSON to comunicate with the mobile app.

## REST Resources

Rails heavily encourages the use of resources. A resource is the term used for a collection of similar objects, such as posts, people or animals. You can do the CRUD operations on items for a resource. In Rails this resources are also standard REST resources.

REST stands for Representational State Transfer. It relies on a stateless, client-server, cacheable communications protocol — and the HTTP protocol is used.

It is an architecture style for designing networked applications. The idea is that, rather than using complex mechanisms such as CORBA, RPC or SOAP to connect between machines, simple HTTP is used to make calls between machines.

RESTful applications use HTTP requests to post data (create and/or update), read data (e.g., make queries), and delete data. Thus, REST uses HTTP verbs (mainly: GET, POST, PUT and DELETE) for all four CRUD operations.

Rails provides a resources method which can be used to declare a standard REST resource. Here's how config/routes.rb will look like.

## Scaffolding of resources

Rails scaffolding is a quick way to generate some of the major pieces of an application. If you want to create the models, views, and controllers for a new resource in a single operation, scaffolding is the tool for the job.

Let's start and create a new resource that we call `User` and that will represent the users of our application. For now the users have only one field for the full name:

```
rails g scaffold User name
```

A lot of things were created with a single command!

#### Migrations

One of the files created with the above command is what we call a **migration**.

Migrations are a convenient way to alter your database schema over time in a consistent and easy way. They use a Ruby DSL (Domain Specific Language) so that you don't have to write SQL by hand, allowing your schema and changes to be database independent.

You can think of each migration as being a new 'version' of the database. A schema starts off with nothing in it, and each migration modifies it to add or remove tables, columns, or entries. Active Record knows how to update your schema along this timeline, bringing it from whatever point it is in the history to the latest version. Active Record will also update your `db/schema`.rb file to match the up-to-date structure of your database.

You should have a file with timestamp in `app/db/migrate` folder and the content is something like this:

```ruby
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end
  end
end
```

The `t.timestamps` line will automagically add `created_at` and `updated_at` fields in the `users` table that will have their values set by Rails. To change our database we must *migrate* it to this new state where it will have the `users` table, using rake command:

```
rake db:migrate
```

By default Rails will use SQLite as the default database, because it doesn't need configuration and it's OK for simple development purposes. In real projects you won't stick with it for long, but for this tutorial we will be just fine with SQLite.

> Rake is a build language, similar in purpose to make and ant. Like make and ant it's a Domain Specific Language, unlike those two it's an internal DSL programmed in the Ruby language.

#### Know your routes

If you check your `app/config/routes.rb` you can see that the scaffold generator also creates a `resources :users` line. This is telling Rails that there's a `User` model with default CRUD actions.

You can always check your routes using the following command:

```
rake routes
```

And by now here's what the output should be:

```
   Prefix Verb   URI Pattern               Controller#Action
    users GET    /users(.:format)          users#index
          POST   /users(.:format)          users#create
 new_user GET    /users/new(.:format)      users#new
edit_user GET    /users/:id/edit(.:format) users#edit
     user GET    /users/:id(.:format)      users#show
          PATCH  /users/:id(.:format)      users#update
          PUT    /users/:id(.:format)      users#update
          DELETE /users/:id(.:format)      users#destroy
     root GET    /                         welcome#index
```

> The `:id` on the URI will be replaced with the numeric id for each user. Rails automatically creates the `id` column for every model.

Note that we have `users#new` and `users#edit` that aren't mentioned on the basic CRUD operations. That's because these two are only to present web forms to input data for the `create` and `update` operations.

If we fire up the WEBrick again we'll see a lot of things working right now. Go to `localhost:3000/users` and you can see that CRUD operations for users are working!

You probably noticed that every URL has a `(.:format)` in the end. This means that it accepts .html, .json, .xml or whatever format you define. By default you can ommit the format and Rails will use the one that it considers the default format (in this case HTML is the default format).

If you access `localhost:3000/users.json` you can see that your controllers already respond to JSON format but it isn't the default. To make it default change the `routes.rb` file to:

```ruby
resources :users, defaults: { format: 'json' }
```

And now you can use the route without extension and get JSON objects!

## Adding tasks

Let's add our second model, called `Task` to our application:

```
rails g scaffold task title completed:boolean user_id:integer
```

Our `tasks` table will have a title, a completed field (if it's complete or not) and an user id. Note that every field that is not `string` should explicitly tell what is the type of data.

Running that command we generate the same files we did when we scaffolded the `User` model. After this we must run the migration:

```
rake db:migrate
```

If you access `localhost:3000/tasks` you'll see that there is already the HTML views to interact with tasks like the ones for the `User`.

## The Rails console and Active Record ORM

Active Record let's you

#### Namespacing the API

Our mobile application will only use the JSON routes to communicate. Usually you don't want to expose the same actions for frontend or backoffice HTML pages and the JSON API. That's where namespacing can help you out.

Change the routes file to use `v1` as the namespace for the API routes, using JSON as the default format:

```ruby
  namespace 'v1', defaults: { format: 'json' } do
    resources :tasks
    resources :users
  end
```

You can keep the other `resources` calls out of the namespace to use them like a rudimentary backoffice.

Because we namespaced the resources we also have to namespace the controllers. We must create the 'v1' directory inside the controllers and make a copy of our controllers inside of it. The class name of the controllers should also be changed to have `V1::` before. We end up with `V1::TasksController` and `V1::UsersController`.

Edit those controllers and delete everything that has to do with rendering stuff for HTML (because the API doesn't need it). We can also delete the edit and new methods because the "form" for creation will be on the mobile side. Since we can't check the "details" of each task we can also delete the show method.

We should also apply these changes in the routes:

```ruby
  namespace 'v1', defaults: { format: 'json' } do
    resources :tasks, only: [:index, :create, :update, :destroy]
    resources :users, only: [:create]
  end
```

## User authentication

For a faster and easier authentication we will use a gem called devise.

r g devise:install
r g devise User

fazer o sessions

config.token_authentication_key = :auth_token

protect_from_forgery with: :null_session

params.permit(:name, :email, :password)

validates :name, presence: :true

render json: @user.as_json.merge!(authentication_token: @user.authentication_token)

before_save :ensure_authentication_token
