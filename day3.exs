defmodule Day3 do
  def move(data), do: (move data, MapSet.new(), 0, 0)

  # Coords grow like a math plot, x horizontal, y, vertical, on bottom left.
  defp move(<<>>, current, x, y), do: MapSet.size(MapSet.put(current, {x,y}))
  defp move(<<"^", tail::binary>>, current, x, y), do: (move tail, MapSet.put(current, {x,y}), x, y+1)
  defp move(<<"v", tail::binary>>, current, x, y), do: (move tail, MapSet.put(current, {x,y}), x, y-1)
  defp move(<<">", tail::binary>>, current, x, y), do: (move tail, MapSet.put(current, {x,y}), x+1, y)
  defp move(<<"<", tail::binary>>, current, x, y), do: (move tail, MapSet.put(current, {x,y}), x-1, y)
end


data = File.read! "day3.txt"

IO.inspect (Day3.move data)
