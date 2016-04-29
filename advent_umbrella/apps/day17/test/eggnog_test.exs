defmodule EggnogTest do
  use ExUnit.Case

  defp load_specs(filename) do
    filename
    |> File.stream!([:read])
    |> Enum.reduce([], fn row, acc ->
        acc ++ [String.to_integer (String.strip row)]
      end)
  end

  test "20 liters" do
    assert 4 == Eggnog.options(25, [20, 15, 10, 5, 5])
  end

  
  test "Advent part 1" do
    buckets = load_specs("test/day17.txt")
    assert 654 == Eggnog.options(150, buckets)
  end
end