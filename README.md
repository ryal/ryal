# Ryal

[![Build Status](https://travis-ci.org/ryal/ryal.svg?branch=master)](https://travis-ci.org/ryal/ryal)

[**[rahy-uh l]**](http://www.dictionary.com/browse/ryal)

noun

1. [rose noble](http://www.dictionary.com/browse/rose-noble).
2. a former gold coin of Scotland, equal to 60 shillings.
3. a former silver coin of Scotland, equal to 30 shillings.

An commerce library for elixir.

## Usage

Ryal is a wrapper over several packages. Each one has its own purpose, but they all depend on two dependencies: Ecto and Ryal Core.
The core concept of Ryal is to make it easier for you to make money, which is essencially what the core is: a payment system.
If you're making a SaaS product and need to accept credit cards, the ryal_core package is all you need.
This is basically all Ryal tries to do at the end of the day: put money in your bank account.

Each app inside of Ryal has a Readme which will detail exactly how to use that dependency.
Each Ryal package has its own methods points of being configured and you should refer to those on their usage and configuration steps.

## Quick Setup

Add this bad boy to your `config.exs` and replace `App` with the name of your application.
We're setting it to `:ryal_core` because that's what everything builds off of.

```elixir
config :ryal_core, repo: App.Repo
```

Now you'll want to copy over the migrations.

```shell
mix ryal.install
```

And, to mount the API (if you'll be using it), add this line to your router:

```elixir
forward "/api", Ryal.Api.Router
```

## Contributing

Don't hesitate to open a PR!
We're always happy to help out.
If you have a question, a bug report, or a performance issue, we're happy to hear about it and answer it.
Also, this project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

## License

This package is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
