## Part 1: Denormalization

Welcome to Score (or Point) Board App! Things would be great if things weren't so slow.

We have a pre-built Rails application with two models: `User` and `Point`.  After seeding the database with data, you'll have 100,000 rows in the `users` table and 1,500,000 rows in the `points` table.  The index page is sl-o-o-ow and it's your job to speed it up without using any fancy technologies like [memcache](http://memcached.org/), [redis](http://redis.io/), or Rails' [fragment caching](http://guides.rubyonrails.org/caching_with_rails.html).

### Setting Up the Application

Clone this repository, checkout a feature branch, then get the application running as follows:

```text
$ bundle install
$ rake db:setup
```

The `rake db:setup` command could take a few minutes.  Once it's done run `rails server` and visit [http://localhost:3000](http://localhost:3000).

We use a gem called activerecord-import to mass import data into the database. Here is an issue to be aware of:  [this issue](https://github.com/zdennis/activerecord-import/wiki/Callbacks)
It should take a few seconds to load.  If you look at the last line of your server logs, you'll see it telling you how much time was spent rendering the views versus how much time was executing `ActiveRecord` methods.  Where's the bottleneck?

### Make it fast!

Your goal is to get the index page to load in under **200ms**.  Yes, that's milliseconds.  You're permitted to do the following:

1. Add new fields to the `users` and `points` tables
2. Add new indexes to the `users` and `points` tables
3. Add new class or instance methods to the `User` or `Point` models

The test suite should remain green.  If you add any new public methods make sure you add appropriate corresponding tests.

You **should write a custom rake tasks** to handle populating new database tables.

You **should not** change the controller or view code.

**Submit your solution as a pull request**.

## Part 2: Pagination

Let's add pagination to our application so we can page through all 100,000 users quickly.

Pagination is a common feature so it's worth knowing how it works.

### Multiple Pages

Before you build the UI, make it so you can visit a URL like [http://localhost:3000?page=3](http://localhost:3000?page=3) and have it do the correct thing.  You're free to change the number of users displayed per page.  Read the ActiveRecord documentation on [limit and offset](http://guides.rubyonrails.org/active_record_querying.html#limit-and-offset), which will be necessary to get pagination behavior.

### TDD User.page

Add a method `User.page` that works as follows:

```ruby
User.by_total_points.page(3) # returns the 3rd page of users, sorted by score
```

Write tests for this method and implement it.  If the input is `nil` it should return the first page of users.

### TDD Pagination Links

Because we're already using Twitter Bootstrap, add pagination links to the bottom of the index page using Bootstrap's [pagination component](http://twitter.github.com/bootstrap/components.html#pagination).  Make sure the user experience is correct.  This means:

1. It should display the correct number of pages
2. The correct page should be marked as active
3. If a user is on the first or last page, the previous or next links should be disabled (respectively)

TDD this feature using [capybara](https://github.com/jnicklas/capybara).

**Submit your solution as a pull request**.
