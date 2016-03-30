defmodule JsonCounter do

  @moduledoc """
  Calculates the sum of all integers in a json string/file.
  """

  def count(json, option \\ :count_all) do
    json
    |> Poison.decode!
    |> count_data(option)
  end

  def count_data(x, option) when is_integer(x), do: x
  def count_data(x, option) when is_list(x) do
    x
    |> Enum.map(fn item -> count_data(item, option) end)
    |> Enum.sum
  end
  def count_data(x, option) when is_map(x) do
    #FIXME Try something more declarative?
    if option == :ignore_red and "red" in Map.values(x) do
      0
    else
      x
      |> Map.keys
      |> Enum.map(fn key -> count_data(Map.get(x, key), option) end)
      |> Enum.sum
    end
  end
  def count_data(_, _), do: 0

  def count_file(filename, option \\ :count_all) do
    filename
    |> File.stream!([:read])
    |> Enum.reduce(0, fn row, acc -> count(row, option) + acc end)
  end
end
