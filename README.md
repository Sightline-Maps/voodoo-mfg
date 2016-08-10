# Voodoo

An HTTP client for Voodoo Manufacturing.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `voodoo` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:voodoo, "~> 0.1.0"}]
    end
    ```

  2. Ensure `voodoo` is started before your application:

    ```elixir
    def application do
      [applications: [:voodoo]]
    end
    ```

And add configuration to `config.exs`:

```elixir
config :voodoo,
  secret_key: System.get_env("VOODOO_KEY"),
  api_host: System.get_env("VOODOO_HOST")
```
