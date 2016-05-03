defmodule ConwayTest do
  use ExUnit.Case

  defp parse_row(row_idx, row) do
    row
    |> String.to_char_list
    |> Enum.with_index
    |> Enum.reduce(%{}, fn {cell, col_idx}, acc -> 
         Map.put(acc, {row_idx, col_idx}, Conway.living?(cell))
       end)
  end

  defp load_specs(filename) do
    filename
    |> File.stream!([:read])
    |> Enum.map(&String.strip/1)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn {row, idx}, acc ->
        Map.merge(acc, parse_row(idx, row))
      end)
  end

  test "sample part 1" do
    grid = "test/sample.txt"
    |> load_specs
    |> Conway.evolve(4)

    assert 4 == Conway.how_many_living?(grid)
  end

  test "sample part 2" do
    grid = "test/sample.txt"
    |> load_specs
    |> Conway.light_up_corners
    |> Conway.evolve(5, [:stuck_corners ])

    assert 17 == Conway.how_many_living?(grid)
  end

  test "part 1" do
    grid = "test/day18.txt"
    |> load_specs
    |> Conway.evolve(100)

    assert 821 == Conway.how_many_living?(grid)
  end

  test "part 2" do
    grid = "test/day18.txt"
    |> load_specs
    |> Conway.light_up_corners
    |> Conway.evolve(100, [:stuck_corners])

    assert 886 = Conway.how_many_living?(grid)
  end
end