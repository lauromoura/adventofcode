defmodule Gifter do
  defstruct homes: MapSet.new(), x: 0, y: 0
end

defmodule Day3 do

  defp update(%Gifter{homes: homes, x: x, y: y}, delta_x, delta_y) do
    %Gifter{homes: MapSet.put(homes, {x, y}), x:  x + delta_x, y: y + delta_y}
  end

  def move(data), do: (move data, %Gifter{}, %Gifter{})

  # Coords grow like a math plot, x horizontal, y, vertical, on bottom left.
  defp move(<<>>, first, second) do
    second = update(second, 0, 0) # Add the remaining home to the map.
    MapSet.size(MapSet.union(Map.get(first, :homes), Map.get(second, :homes)))
  end
  #defp move(<<>>, current, x, y), do: MapSet.size(MapSet.put(current, {x,y}))
  defp move(<<"^", tail::binary>>, first, second), do: (move tail, second, update(first, 0, 1))
  defp move(<<"v", tail::binary>>, first, second), do: (move tail, second, update(first, 0, -1))
  defp move(<<">", tail::binary>>, first, second), do: (move tail, second, update(first, +1, 0))
  defp move(<<"<", tail::binary>>, first, second), do: (move tail, second, update(first, -1, 0))
end


data = File.read! "day3.txt"

IO.inspect (Day3.move data)
