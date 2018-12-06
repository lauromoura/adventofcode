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

  def common_letters(boxes) do
    len = String.length(Enum.at(boxes, 0))
    boxes = Enum.map(boxes, &String.to_charlist/1)

    # Simple, brute force approach as the number of ids is 250
    for x <- boxes, y <- boxes do
      Enum.zip(x, y)
    end
    |> Enum.filter(fn pair ->
      Enum.count(pair, fn {x, y} -> x == y end) == len - 1
    end)
    |> hd()
    |> Enum.filter(fn {a, b} -> a == b end)
    |> Enum.map(fn {a, _} -> a end)
    |> List.to_string()
  end
end
