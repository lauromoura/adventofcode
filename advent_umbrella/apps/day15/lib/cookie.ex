defmodule Ingredient do
  defstruct capacity: 0, durability: 0, flavor: 0, texture: 0, calories: 0
end

defmodule Cookie do

  @max 100

  def bake([]), do: 0
  def bake(list=[_|_]) do
    do_bake(list, %Ingredient{})
  end

  defp do_bake([], acc) do
    max(Map.get(acc, :capacity), 0) *
    max(Map.get(acc, :durability), 0) *
    max(Map.get(acc, :flavor), 0) *
    max(Map.get(acc, :texture), 0)
  end
  defp do_bake([{ingredient, quantity}|tail], ingredients) do
    do_bake(tail, Map.merge(ingredient, ingredients,
      fn key, new_value, values_so_far ->
        case key do
          :__struct__ -> new_value
          _ -> values_so_far + new_value * quantity
        end
      end))
  end

  def perfect(ingredients) do
    # FIXME Hardcoded 4 ingredients...
    for x <- 1..100, y <- 1..100, w <- 1..100, z <- 1..100, x+y+w+z == 100 do
      bake Enum.zip(ingredients, [x,y,w,z])
    end
    |> Enum.max
  end

  def parse(row) do
    regex = ~r/(\w+): capacity (-?[0-9]+), durability (-?[0-9]+), flavor (-?[0-9]+), texture (-?[0-9]+), calories (-?[0-9]+)/
    [_, name, capacity, durability, flavor, texture, calories] = Regex.run(regex, String.strip(row))
    ingredient = %Ingredient{capacity: (String.to_integer capacity),
                              durability: (String.to_integer durability),
                              flavor: (String.to_integer flavor),
                              texture: (String.to_integer texture),
                              calories: (String.to_integer calories)}
    ingredient
  end
end