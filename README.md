# iOS on Rails - Part I

This guide assumes that you already have a Ruby on Rails environment. We will also assume that you are using **Rails 4.0.2** and at least **Ruby 1.9.3**.

## Get to know the tools

Here is the list of preferred software for this workshop:

* **Text editor** — Sublime Text ([http://www.sublimetext.com/2](http://www.sublimetext.com/2))

* **Terminal** — Where you start the Rails server and run commands. You must get used to terminal (or you can use iTerm instead).

* **Web browser** — Your backoffice will be visible on one of these. Preferably Chrome.

## Creating the application

Today we will be creating a simple web application for you to manage your daily tasks and your TODO list. This application will let you organize the tasks by category and it's able to support different users, having each one its own set of tasks.

With the help of this web application, several tricks, tips and advices for developing in Ruby on Rails will be presented, like:

We're going to create a new Rails application. You can call it whatever you want. I'll just call it `life_manager`.

First open your terminal type the `rails new` command to create your new project and change current directory:

```
$ rails new life_manager
$ cd life_manager
``
