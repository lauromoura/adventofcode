
defmodule Day1 do
  def move(data), do: (move data, 0, 1)

  defp move(<<>>, _current, i), do: i
  defp move(<<"(", tail::binary>>, current, i), do: (move tail, current + 1, i+1)
  defp move(<<")", _tail::binary>>, 0, i), do: i
  defp move(<<")", tail::binary>>, current, i), do: (move tail, current - 1, i+1)
end


data = File.read! "day1.txt"

IO.puts (Day1.move data)
