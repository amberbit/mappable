defmodule TestStruct do
  defstruct foo: nil
end

defmodule TestStruct2 do
  defstruct bar: nil, foo: nil
end

defmodule MappableTest do
  use ExUnit.Case

  describe "to_map/2 with strings" do
    test "converts to Map with String keys by default" do
      original = %{:foo => :bar}
      converted = Mappable.to_map(original, keys: :strings)

      assert converted == %{"foo" => :bar}
    end

    test "keeps Map with String keys intact" do
      original = %{"foo" => :bar}
      converted = Mappable.to_map(original, keys: :strings)

      assert original == converted
    end

    test "converts nested Maps recursively" do
      original = %{:foo => %{:bar => :baz}}
      converted = Mappable.to_map(original, keys: :strings)

      assert converted == %{"foo" => %{"bar" => :baz}}
    end

    test "converts Struct to Map" do
      original = %TestStruct{:foo => :bar}
      converted = Mappable.to_map(original, keys: :strings)

      assert converted == %{"foo" => :bar}
    end

    test "converts keyword lists to Map" do
      original = [foo: :bar]
      converted = Mappable.to_map(original, keys: :strings)

      assert converted == %{"foo" => :bar}
    end
  end

  describe "to_map/2 with atoms" do
    test "converts to Map with Atom keys if passed such option" do
      original = %{"foo" => :bar}
      converted = Mappable.to_map(original, keys: :atoms)

      assert converted == %{:foo => :bar}
    end

    test "converts nested Maps recursively" do
      original = %{"foo" => %{"bar" => :baz}}
      converted = Mappable.to_map(original, keys: :atoms)

      assert converted == %{:foo => %{:bar => :baz}}
    end

    test "keeps Map with Aom keys intact" do
      original = %{:foo => :bar}
      converted = Mappable.to_map(original, keys: :atoms)

      assert converted == original
    end

    test "converts keyword lists to Map" do
      original = [foo: :bar]
      converted = Mappable.to_map(original, keys: :atoms)

      assert converted == %{:foo => :bar}
    end

    test "preserves nil" do
      assert Mappable.to_map(nil) == nil
    end
  end

  describe "to_struct/2" do
    test "converts Map with String keys to struct" do
      original = %{"foo" => :bar}
      converted = Mappable.to_struct(original, TestStruct)

      assert converted == %TestStruct{foo: :bar}
    end

    test "ignores keys that are not present in destination struct" do
      original = %{"foo" => :bar, "ignore" => :me}
      converted = Mappable.to_struct(original, TestStruct)

      assert converted == %TestStruct{foo: :bar}
    end

    test "converts Map with Atom keys to struct" do
      original = %{:foo => :bar}
      converted = Mappable.to_struct(original, TestStruct)

      assert converted == %TestStruct{foo: :bar}
    end

    test "converts other struct to destination struct" do
      original = %TestStruct2{:bar => :foo, :foo => :bar}
      converted = Mappable.to_struct(original, TestStruct)

      assert converted == %TestStruct{foo: :bar}
    end

    test "preserves nil" do
      assert Mappable.to_struct(nil, TestStruct) == nil
    end
  end

  describe "to_list/1" do
    test "converts maps with String keys" do
      original = %{"foo" => :bar, "bar" => :foo}
      converted = Mappable.to_list(original)

      assert converted == [bar: :foo, foo: :bar]
    end

    test "converts structs" do
      original = %{"foo" => :bar, "bar" => :foo}
      converted = Mappable.to_list(original)

      assert converted == [bar: :foo, foo: :bar]
    end

    test "preserves keyword list" do
      original = [foo: :bar, bar: :foo]
      converted = Mappable.to_list(original)

      assert converted == [foo: :bar, bar: :foo]
    end

    test "preserves nil" do
      assert Mappable.to_list(nil) == nil
    end
  end

  describe "keys/1" do
    test "returns keys from structs" do
      keys = Mappable.keys(%TestStruct2{})
      assert keys == [:bar, :foo]
    end

    test "returns keys from lists" do
      keys = Mappable.keys(first: :item, second: :item)
      assert keys == [:first, :second]
    end

    test "returns keys from maps" do
      keys = Mappable.keys(%{bar: 1, foo: 2})
      assert keys == [:bar, :foo]

      keys = Mappable.keys(%{"bar" => 1, "foo" => 2})
      assert keys == ["bar", "foo"]
    end
  end
end
