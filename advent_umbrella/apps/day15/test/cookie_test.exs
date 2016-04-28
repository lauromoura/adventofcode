defmodule CookieTest do
  use ExUnit.Case

  defp load_specs(filename) do
    filename
    |> File.stream!([:read])
    |> Enum.reduce([], fn row, acc ->
      ingredient = Cookie.parse(row)
      acc ++ [ingredient]
    end)
  end

  test "Basic ingredient test" do
    ingredient = %Ingredient{capacity: 1, durability: 2, flavor: 3, texture: 4 }
  end

  test "Basic bake" do
    butterscotch = %Ingredient{capacity: -1, durability: -2, flavor: 6, texture: 3, calories: 8}
    cinnamon = %Ingredient{capacity: 2, durability: 3, flavor: -2, texture: -1, calories: 3}

    assert 62842880 = Cookie.bake([{butterscotch, 44}, {cinnamon, 56}])
  end

  test "Advent of code part 1" do
    ingredients = load_specs("test/day15.txt")
    assert 0 == Cookie.perfect(ingredients)
  end
end