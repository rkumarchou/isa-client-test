# ISA

## Technology stack

- Ruby 2.7
- Ruby on Rails 6.1.4
- PostgreSQL
- Redis
- Gems:
    -  [active_model_serializers](https://github.com/rails-api/active_model_serializers) | JSON generation
    -  [devise](https://github.com/plataformatec/devise) | Authentication
    -  [Dotenv](https://github.com/bkeepers/dotenv) | Manage environment variable
    -  [pg](https://github.com/ged/ruby-pg) | PostgreSQL library for Ruby
    -  [puma](https://github.com/puma/puma) | Web application server
    -  [Lockbox](https://github.com/ankane/lockbox) | Encryption library for Ruby on Rails
    -  [sidekiq](https://github.com/mperham/sidekiq) | Background processing Ruby
    -  [will_paginate](https://github.com/mislav/will_paginate) | For pagination

## Installation

### Requirements

Before you get started, the following needs to be installed:
   **Ruby**. Version 2.7.0 is currently used. If you need multiple versions of Ruby, [RVM](https://rvm.io//) or [rbenv](https://github.com/rbenv/rbenv) is recommended.
  * [**RubyGems**](http://rubygems.org/)
  * **Bundler**: `gem install bundler`
  * [**Git**](http://help.github.com/git-installation-redirect)
  * **A database**. PostgreSQL is currently used. You can install PostgreSQL server using following ways:
    1. If you are on a Mac, use homebrew: `brew install postgresql`.
    2. Install a [PostgreSQL using following](https://www.postgresql.org/download/linux/ubuntu/)
  * [**Redis**](https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-20-04)

### Setting up the development environment

1.  Get the code. Clone this git repository:

    ```bash
    git clone git@gitlab.com:smalik1/isa-client-test.git
    cd isa-client-test.git
    ```

2.  Install the required gems by running the following command in the project root directory:

    ```bash
    bundle install
    ```

    **Note:** [`pg` might fail to build native extension](https://stackoverflow.com/questions/4827092/unable-to-install-pg-gem), in that case you can try installing pg manually:

    ```bash
    sudo apt-get install libpq-dev

    bundle install
    ```

3.  Create a `database.yml` file by copying the example database configuration:

    ```bash
    cp config/example.database.yml config/database.yml
    ```

4.  Create a `.env` file by copying the example.env configuration:

    ```bash
    cp example.env .env
    ```

5.  Add your database configuration details to `config/database.yml`. You will probably need to fill the username and password for the database(s).

6.  Create and initialize the database:

    ```bash
    bundle exec rake db:create db:migrate db:seed
    ```

7.  Create environment file and initialize the environment variable:

    ```bash
    rails c
    Lockbox.generate_key
    ```
    Create .env file inside project and Set LOCKBOX_MASTER_KEY= Lockbox generated key

8. Start sidekiq for delayed jobs:
    ```bash
    bundle exec sidekiq -C config/sidekiq.yml
    ```

9.  Start the development server:

    ```bash
    rails s
    ```

10.  Api Documentation: Api documentation can be found inside the project directory. File name is ISA.postman_collection.json

11. Manually create jobs:
    
    ```bash
    bundle exec rails "queue_job:create[Job name1, high]"
    rails "queue_job:complete[2]"
    ```

### How to run the test suite

Specs need to be added as an improvement.


Congratulations! ISA should now be up and running for development purposes. Open a browser and go to the server URL (e.g. http://localhost:3000)

