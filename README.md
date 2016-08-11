# Voodoo Manufacturing for Elixir

An HTTP client for the Voodoo Manufacturing API.

  - [Voodoo.Material](https://github.com/Sightline-Maps/voodoo-mfg/blob/master/lib/voodoo/material.ex)
  - [Voodoo.Model](https://github.com/Sightline-Maps/voodoo-mfg/blob/master/lib/voodoo/model.ex)
  - [Voodoo.Order](https://github.com/Sightline-Maps/voodoo-mfg/blob/master/lib/voodoo/order.ex)

## Installation

Soon to be available at `hex.pm`. The package can be installed as:

Add `voodoo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:voodoo_mfg, "~> 0.1.0"}]
end
```

Ensure `voodoo` is started before your application:

```elixir
def application do
  [applications: [:voodoo_mfg]]
end
```

## Configuration

And add configuration to `config.exs`:

```elixir
use Mix.Config

config :voodoo_mfg,
  secret_key: System.get_env("VOODOO_SECRET_KEY"),
  api_host: System.get_env("VOODOO_HOST")
```

For local development and testing, the host should be:

```
https://staging-api.voodoomfg.com/api/1
```

For production, the host should be:

```
https://api.voodoomfg.com/api/1
```

## Examples

Examples can be found inline with the function in the file for each module:

- [Voodoo.Material](https://github.com/Sightline-Maps/voodoo-mfg/blob/master/lib/voodoo/material.ex)
- [Voodoo.Model](https://github.com/Sightline-Maps/voodoo-mfg/blob/master/lib/voodoo/model.ex)
- [Voodoo.Order](https://github.com/Sightline-Maps/voodoo-mfg/blob/master/lib/voodoo/order.ex)
