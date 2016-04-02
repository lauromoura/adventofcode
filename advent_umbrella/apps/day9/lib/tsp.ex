defmodule Tsp do

  @moduledoc """
  Provides a naive solution for a TSP-like (Traveling Salesman problem) solver.

  The difference to the tradicional TSP is that the path does not need to go
  back to the starting node.
  """

  defp calculate_distance(data, func, option) do
    trajectories = data
    |> extract_cities
    |> MapSet.to_list
    |> permutations # FIXME Permutations work for complete graphs. Replace with a walk.

    if option == :round_trip do
      trajectories = add_round_trip(trajectories)
    end

    trajectories
    |> Enum.map(fn trajectory ->
         # IO.inspect(trajectory)
         distance(data, trajectory)
       end)
    |> func.()
  end

  def shortest_distance(data, option \\ :no_back) do
    calculate_distance(data, &Enum.min/1, option)
  end

  def longest_distance(data, option \\ :no_back) do
    calculate_distance(data, &Enum.max/1, option)
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

  defp add_round_trip(trajectories) do
    for x=[h|_] <- trajectories do
      [h|Enum.reverse(x)]
    end
  end

  defp distance(graph, trajectory = [a, b | tail]) do
    dist = distance_between(graph, a, b)
    # IO.inspect(dist)
    dist + distance(graph, [b|tail])
  end
  defp distance(graph, [_a | []]), do: 0

  defp distance_between(graph, a, b) do
    Map.get(graph, {a, b})
  end

  def make_key(a, b) do
    List.to_tuple(Enum.sort [a, b])
  end

  def add_edge(graph, from, to, distance) do
    Map.put(graph, {from, to}, distance)
  end
end
