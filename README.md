# Ryal

[![Build Status](https://travis-ci.org/ryal/ryal.svg?branch=master)](https://travis-ci.org/ryal/ryal)
[![Coverage Status](https://coveralls.io/repos/github/ryal/ryal/badge.svg)](https://coveralls.io/github/ryal/ryal)
[![Hex.pm](https://img.shields.io/hexpm/v/ryal.svg)]()

[**[rahy-uh l]**](http://www.dictionary.com/browse/ryal)

noun

1. [rose noble](http://www.dictionary.com/browse/rose-noble).
2. a former gold coin of Scotland, equal to 60 shillings.
3. a former silver coin of Scotland, equal to 30 shillings.

An e-commerce library for elixir.

## Usage

Ryal is a wrapper over several packages. Each one has its own purpose, but they all depend on two dependencies: Ecto and Ryal Core.
The core concept of Ryal is to make it easier for you to make money, which is essencially what the core is: a payment system.
If you're making a SaaS product and need to accept credit cards, the ryal_core package is all you need.
This is basically all Ryal tries to do at the end of the day: put money in your bank account.

Each app inside of Ryal has a Readme which will detail exactly how to use that dependency.
Each Ryal package has its own methods points of being configured and you should refer to those on their usage and configuration steps.

## Quick Setup

First and foremost, add Ryal to your mixfile and each umbrella application to the applications.

```elixir
# mix.exs

defp applications do
  [:ryal_core]
end

defp deps do
  [
    {:ryal, "~> 0.x"}
    # or, if you're brave and trust us (which you shouldn't):
    {:ryal, github: "ryal/ryal"}
  ]
end
```

Add this bad boy to your `config.exs` and replace `App` with the name of your application.
We're setting it to `:ryal_core` because that's what everything builds off of.

```elixir
config :ryal_core,
  repo: App.Repo,
  user_module: App.User,
  user_table: :users,
  default_payment_gateway: :bogus,
  fallback_payment_gateways: [:stripe, :braintree]
```

Now you'll want to copy over the migrations.

```shell
mix ryal.install
```

And, to mount the API (if you'll be using it), add this line to your router:

```elixir
forward "/api", Ryal.Api.Router
```

Also, please don't forget to add pagination via [Scrivener](https://github.com/drewolson/scrivener) to your `Repo`:

```elixir
defmodule App.Repo do
  use Ecto.Repo, otp_app: :app
  use Scrivener, page_size: 20
end
```

## Contributing

Don't hesitate to open a PR!
We're always happy to help out.
If you have a question, a bug report, or a performance issue, we're happy to hear about it and answer it.
Also, this project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

### Development

Run this command over every package that you wish to test:

```shell
MIX_ENV=test mix db.reset
```

Then run the tests:

```shell
mix test
```

## License

This package is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
