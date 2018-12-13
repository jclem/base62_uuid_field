# Base62UUIDField [![Build Status](https://travis-ci.com/jclem/base62_uuid_field.svg?branch=master)](https://travis-ci.com/jclem/base62_uuid_field) [![Coverage Status](https://coveralls.io/repos/github/jclem/base62_uuid_field/badge.svg?branch=master)](https://coveralls.io/github/jclem/base62_uuid_field?branch=master)

An [Ecto.Type](https://hexdocs.pm/ecto/Ecto.Type.html) for Base62-encoded UUIDs.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `base62_uuid_field` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:base62_uuid_field, "~> 1.0.0"}
  ]
end
```

## Usage

This Ecto type builds on top of the existing `Ecto.UUID` type, except that it ensures that the types at runtime are represented as [Base62-encoded UUIDs](https://github.com/jclem/base62_uuid).

For example, given an `identity_users` table with a `:binary_id` primary key:

```elixir
create table(:identity_users, primary_key: false) do
  add :id, :binary_id, primary_key: true
end
```

We can have Base62-encoded primary keys at runtime instead of much longer and less URL-friendly hexadecimal-encoded UUIDs.

```elixir
defmodule App.Identity.User do
  use Ecto.Schema

  @primary_key {:id, Base62UUIDField, autogenerate: true}

  # ...etc.
end
```

```elixir
iex> %App.Identity.User{} |> App.Identity.User.changeset(%{}) |> App.Repo.insert!()
%App.Identity.User{
  __meta__: #Ecto.Schema.Metadata<:loaded, "identity_users">,
  id: "6UupZ56JriyqxwjYXR9Aiz",
  inserted_at: ~N[2018-12-13 18:22:57],
  updated_at: ~N[2018-12-13 18:22:57]
}
```
