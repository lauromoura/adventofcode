defmodule JsonCounter do

  @moduledoc """
  Calculates the sum of all integers in a json string/file.
  """

  def count(json) do
    json
    |> Poison.decode!
    |> count_data
  end

  def count_data(x) when is_integer(x), do: x
  def count_data(x) when is_list(x) do
    x
    |> Enum.map(fn item -> count_data(item) end)
    |> Enum.sum
  end
  def count_data(x) when is_map(x) do
    x
    |> Map.keys
    |> Enum.map(fn key -> count_data(Map.get(x, key)) end)
    |> Enum.sum
  end
  def count_data(_), do: 0

  def count_file(filename) do
    filename
    |> File.stream!([:read])
    |> Enum.reduce(0, fn row, acc -> count(row) + acc end)
  end
end
