defmodule GraphTest do
  use ExUnit.Case

  @sample_graph %{{:a, :b} => 100, {:b, :c} => 50}

  test "Add edge test" do
    graph = %{}
    |> Graph.add_edge(:a, :b, 100)
    |> Graph.add_edge(:b, :c, 50)

    assert @sample_graph == graph
  end

  test "Getting nodes from a graph" do
    assert :a in Graph.nodes(@sample_graph)
  end

  test "Distance test" do
    assert 50 == Graph.distance(@sample_graph, :b, :c)
  end

  test "Neighbours test" do
    assert MapSet.new([:b]) == Graph.neighbours(@sample_graph, :a)
    assert MapSet.new([:a, :c]) == Graph.neighbours(@sample_graph, :b)
  end

  test "Paths test: connected graph" do
    graph = %{}
    |> Graph.add_edge(:a, :b, 10)
    |> Graph.add_edge(:b, :a, 10)
    |> Graph.add_edge(:a, :c, 10)
    |> Graph.add_edge(:c, :a, 10)
    |> Graph.add_edge(:b, :c, 10)
    |> Graph.add_edge(:c, :a, 10)

    paths = Graph.paths(graph)

    reference = %MapSet{}
    |> MapSet.put([:a, :b, :c])
    |> MapSet.put([:a, :c, :b])
    |> MapSet.put([:b, :a, :c])
    |> MapSet.put([:b, :c, :a])
    |> MapSet.put([:c, :b, :a])
    |> MapSet.put([:c, :a, :b])

    assert reference == MapSet.new(paths)
  end
end