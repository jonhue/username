# Username

[![Gem Version](https://badge.fury.io/rb/username.svg)](https://badge.fury.io/rb/username) <img src="https://travis-ci.org/jonhue/username.svg?branch=master" />

Usernames for ActiveRecord model.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
    * [Methods](#methods)
* [Configuration](#configuration)
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
    * [Semantic versioning](#semantic-versioning)
* [License](#license)

---

## Installation

Username works with Rails 5 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'username'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install username

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'username', github: 'jonhue/username'
```

Now run the generator:

    $ rails g username

---

## Usage

You can add usernames to an ActiveRecord model:

```ruby
class User < ApplicationRecord
    has_username
end
```

**Important:** Make sure to add a `username` string column to the corresponding database table.

Username adds a validator to prevent the use of invalid usernames.

### Methods

```ruby
# If a username is valid for an ActiveRecord class
User.username_valid? 'test'

# If a username is available for an ActiveRecord model
User.first.username_available? 'test'
```

---

## Configuration

You can configure Username by passing a block to `configure`. This can be done in `config/initializers/username.rb`:

```ruby
Username.configure do |config|
    config.forbidden = []
end
```

* `forbidden` Array of forbidden usernames. Takes an array of strings. Defaults to `[]`.
* `minlength` Minimum length for usernames. Takes an integer. Defaults to `1`.
* `maxlength` Maximum length for usernames. Takes an integer. Defaults to `20`.
* `regex` Strings not matching this regular expression are invalid as usernames. Takes a regular expression. Defaults to `/\A[a-zA-Z0-9_\.]*\z/`.
* `global_uniqueness` Whether to validate usernames across all models or just the records model. Takes a boolean. Defaults to `true`.

---

## To Do

[Here](https://github.com/jonhue/username/projects/1) is the full list of current projects.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/username/issues/new).

---

## Contributing

We hope that you will consider contributing to Username. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](CONTRIBUTING.md), [Code of Conduct](CODE_OF_CONDUCT.md)

### Contributors

Give the people some :heart: who are working on this project. See them all at:

https://github.com/jonhue/username/graphs/contributors

### Semantic Versioning

Username follows Semantic Versioning 2.0 as defined at http://semver.org.

## License

MIT License

Copyright (c) 2018 Jonas Hübotter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
