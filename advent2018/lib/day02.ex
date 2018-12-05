defmodule Day02 do
  def checksum(boxes) do
    boxes_counts = Enum.map(boxes, &count/1)
    twos = Enum.filter(boxes_counts, &MapSet.member?(&1, 2)) |> Enum.count()
    threes = Enum.filter(boxes_counts, &MapSet.member?(&1, 3)) |> Enum.count()
    twos * threes
  end

  defp count(word) do
    word
    |> String.to_charlist()
    |> Enum.reduce(%{}, fn x, acc ->
      Map.update(acc, x, 1, &(&1 + 1))
    end)
    |> Map.values()
    |> MapSet.new()
  end
end
