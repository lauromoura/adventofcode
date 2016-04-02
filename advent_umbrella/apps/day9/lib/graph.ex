defmodule Graph do
  def add_edge(graph=%{}, from, to, distance) do
    Map.put(graph, {from, to}, distance)
  end

  def nodes(graph=%{}) do
    graph
    |> Map.keys
    |> Enum.reduce(%MapSet{}, fn {from, to}, acc ->
      acc = MapSet.put(acc, from)
      MapSet.put(acc, to)
    end)
  end

  def distance(graph=%{}, from, to) do
    Map.get(graph, {from, to})
  end

  def neighbours(graph=%{}, node) do
    graph
    |> nodes
    |> Enum.filter(fn item ->
         Map.has_key?(graph, {node, item}) or Map.has_key?(graph, {item, node})
       end)
    |> MapSet.new
  end

  def paths(graph=%{}) do
    Enum.reduce(nodes(graph), [], fn node, acc ->
      remaining = MapSet.delete(nodes(graph), node)
      [do_path(graph, node, remaining) | acc]
    end)
  end

  defp do_path(graph, starting, remaining) do
    IO.inspect(starting)
    IO.inspect(remaining)
    for candidate <- neighbours(graph, starting), candidate in remaining do
      [starting | do_path(graph, candidate, MapSet.delete(remaining, candidate))]
    end
  end
end