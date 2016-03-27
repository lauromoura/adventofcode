defmodule TspTest do
  use ExUnit.Case

  test "Simple test" do
    graph = %{{:a, :b} => 10, {:b, :c} => 25, {:a, :c} => 5}
    assert 15 = Tsp.shortest_distance(graph)
  end

  test "Sample from advent of code" do
    graph = load_graph_from_file("test/sample.txt")
    assert 605 == Tsp.shortest_distance(graph)
  end

  test "Actual data for part one" do
    graph = load_graph_from_file("data/day9.txt")
    assert 207 == Tsp.shortest_distance(graph)
  end

  defp load_graph_from_file(filename) do
    regex  = ~r/(\w+) to (\w+) = (\d+)/
    Enum.reduce(File.stream!(filename), %{},
      fn line, acc ->
        [_row, start, final, distance] = Regex.run(regex, String.strip line)
        key = Tsp.make_key(start, final)
        Map.put(acc, key, String.to_integer distance)
      end)
  end
end
