# Ryal Core

[![Hex.pm](https://img.shields.io/hexpm/v/ryal_core.svg)](https://hexdocs.pm/ryal_core/)

The core of Ryal; probably already guessed that...

Ryal Core manages two main components: orders and payments.
It's kinda hard to run any type of an e-commerce application without at least the two guys.

Payments is structured so that you can process payments with redundancy.
Ryal aims to support multiple payment methods and gateways while, at the same time, creating a profile per user to each of the gateways incase one of them goes down for a few hours.

## Installation

  1. Add `ryal_core` to your list of dependencies in `mix.exs`:
    ```elixir
    def deps do
      [{:ryal_core, "~> 0.x"}]
    end
    ```

  2. Ensure `ryal_core` is started before your application:
    ```elixir
    def application do
      [applications: [:ryal_core]]
    end
    ```

## Schema

```
┌───────────────────┐    ┌─────────┐    ┌───────┐
│ PaymentTransition ╞────┤ Payment ╞────┤ Order ╞┐
└───────────────────┘    └────╥────┘    └───────┘│
                              │                  │
                              │                  │
 ┌───────────────┐    ┌───────┴──────────────┐   │
 │ PaymentMethod ├────╡ PaymentMethodGateway │   │
 └──────╥────────┘    └───────────╥──────────┘   │
        │                         │              │
        │                         │              │
    ┌───┴──┐             ┌────────┴───────┐      │
    │ User ├─────────────╡ PaymentGateway │      │
    └──┬───┘             └────────────────┘      │
       │                                         │
       └─────────────────────────────────────────┘
```

## Development

To setup the test database:

```shell
MIX_ENV=test mix db.reset
```

Then run the test command:

```shell
mix test
```
