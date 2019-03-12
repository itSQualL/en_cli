# EnCli

API wrapper for engima


## Installation

Add `en_cli` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:en_cli, "~> 0.3.0"}
  ]
end
```

And finally add to your `config.exs`:

```elixir
config :en_cli,
  base_uri: "https://domain.com/api/v1",
  username: "your_username",
  token: "your_token"

```

Documentation at [https://hexdocs.pm/en_cli](https://hexdocs.pm/en_cli/EnCli.html).
