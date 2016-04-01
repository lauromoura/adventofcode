defmodule Tsp do

  @moduledoc """
  Provides a naive solution for a TSP-like (Traveling Salesman problem) solver.

  The difference to the tradicional TSP is that the path does not need to go
  back to the starting node.
  """

  defp calculate_distance(data, func) do
    data
    |> extract_cities
    |> MapSet.to_list
    |> permutations
    |> Enum.map(fn trajectory ->
         distance(data, trajectory)
       end)
    |> func.()
  end

  def shortest_distance(data) do
    calculate_distance(data, &Enum.min/1)
  end

  def longest_distance(data) do
    calculate_distance(data, &Enum.max/1)
  end

  defp extract_cities(cities = %{}) do
    keys = Map.keys(cities)
    Enum.reduce(keys, %MapSet{}, fn {a, b}, acc ->
      acc = MapSet.put(acc, a)
      MapSet.put(acc, b)
    end)
  end

  defp permutations([]) do
    [[]]
  end
  defp permutations(list) do
    for h <- list, t <- permutations(list -- [h]) do
      [h | t]
    end
  end

  defp distance(graph, trajectory = [a, b | tail]) do
    dist = distance_between(graph, a, b)
    dist + distance(graph, [b|tail])
  end
  defp distance(graph, [_a | []]), do: 0

  defp distance_between(graph, a, b) do
    key = make_key(a, b)
    Map.get(graph, key)
  end

  def make_key(a, b) do
    List.to_tuple(Enum.sort [a, b])
  end
end
