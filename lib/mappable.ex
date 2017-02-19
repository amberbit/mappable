defmodule Mappable do
  def to_map(struct_or_map, options) do
    case Map.has_key?(struct_or_map, :__struct__) do
      true -> Map.from_struct(struct_or_map)
      false -> struct_or_map
    end |> Enum.reduce(%{}, fn ({k, v}, acc) -> Map.put(acc, convert_key(k, options[:keys]), v) end)
  end

  defp convert_key(k, :atoms) when is_atom(k) do
    k
  end

  defp convert_key(k, :atoms) when is_binary(k) do
    String.to_atom(k)
  end

  defp convert_key(k, :strings) do
    "#{k}"
  end

  def to_struct(map, struct_module) when is_atom(struct_module) do
    struct = struct(struct_module)

    Enum.reduce Map.to_list(struct), struct, fn {k, _}, acc ->
      case Map.fetch(to_map(map, keys: :strings), convert_key(k, :strings)) do
        {:ok, v} -> %{acc | k => v}
        :error -> acc
      end
    end
  end
end

