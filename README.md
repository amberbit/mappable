# Mappable

Simple module that provides unified, simple interface for converting
between different dictionary-like data types in Elixir:

- maps
- structs
- keyword lists

## Examples

Use `Mappable.to_map map, keys: :strings` to convert anything to map
with string keys recursively:

    %{:foo => :bar}
    |> Mappable.to_map(keys: :strings)
    => %{"foo" => :bar}

Use `keys: :atoms` to do the same but use atom keys:

    %{"foo" => %{"bar" => :baz}}
    |> Mappable.to_map(keys: :atoms)
    => %{:foo => %{:bar => :baz}}

Convert anything to struct easily by matching keys:

    %{"id" => 1, "email" => "jack.black@example.com"}
    |> Mappable.to_struct(User)
    => %User{id: 1, email: "jack@black@example.com"}

Convert anything to keyword list with:

    %{"bar" => :foo, "foo" => :bar}
    > Mappable.to_list
    => [bar: :foo, foo: :bar]


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `mappable` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:mappable, "~> 0.2.0"}]
end
```

## Documentation

Documentation on [HexDocs](https://hexdocs.pm/mappable).

