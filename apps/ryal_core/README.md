# Ryal Core

[![Hex.pm](https://img.shields.io/hexpm/v/ryal_core.svg)](https://hexdocs.pm/ryal_core/)

The core of Ryal; probably already guessed that...

## Installation

  1. Add `core` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ryal_core, "~> 0.x"}]
    end
    ```

  2. Ensure `core` is started before your application:

    ```elixir
    def application do
      [applications: [:ryal_core]]
    end
    ```
