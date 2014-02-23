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

#### Views

Views are responsible for the visible part of the application or what the user actually sees. It can be HTML markup to be displayed in a browser but could be XML, JavaScript, JSON, or any other.

#### Models

Models are the representation of the objects (users, personal data, friendships, etc.), involved in the application so called "business logic".
While we call the entire layer "the model", Rails applications are usually made up of several individual models, each of which (usually) maps to a database table.

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

## Scaffolding

We will be using the `rails` command a lot. If you want type `rails` with no arguments inside your application to check what you can do. Go ahead and type `rails generate`. This command is used to generate different things like controllers, models, etc.

> **Note**: every command has a shortcut. `rails generate` can be written as `rails g`, `rails server` can be written as `rails s` and so on.

