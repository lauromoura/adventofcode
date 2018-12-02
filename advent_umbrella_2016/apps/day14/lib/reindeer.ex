defmodule Reindeer do

  defp distance(speed, run_time, rest_time, duration) do
    iter_time = run_time + rest_time
    speed * ((run_time * div(duration, iter_time)) + min(rem(duration, iter_time), run_time))
  end
  def run(reindeers = %{}, name, duration) do
    {speed, run_time, rest_time} = Map.get(reindeers, name)
    distance(speed, run_time, rest_time, duration)
  end

  def winner(reindeers = %{}, duration) do
    reindeers
    |> Enum.max_by(fn {name, {speed, run_time, rest_time}} ->
                     {distance(speed, run_time, rest_time, duration), name}
                   end)
    |> elem(0)
  end

  def points_race(reindeers = %{}, duration) do
    score = Enum.reduce(reindeers, %{}, fn {k, _v}, acc ->
      Map.put(acc, k, 0)
    end)
    do_points_race(reindeers, score, duration)
  end
  defp do_points_race(_reindeers = %{}, score = %{}, 0), do: score
  defp do_points_race(reindeers = %{}, score = %{}, duration) when duration > 0 do
    distances = Enum.map(reindeers,
                         fn {k, _} ->
                           {k, run(reindeers, k, duration)}
                         end)
    updated_score = Enum.reduce(round_winners(distances),
                                score,
                                fn player, new_score ->
                                  Map.update!(new_score, player, &(&1 + 1))
                                end)
    do_points_race(reindeers, updated_score, duration - 1)
  end

  defp round_winners(distances) do
    {_, winning_distance} = Enum.max_by(distances, fn {_k, v} -> v end)
    distances
    |> Enum.filter(fn {_k, v} -> v == winning_distance end)
    |> Keyword.keys
  end

  def points_winner(results = %{}) do
    results
    |> Enum.max_by(&(elem(&1, 1)))
    |> elem(1)
  end

  def parse(row) do
    regex = ~r/(\w+) can fly ([0-9]+) km\/s for ([0-9]+) seconds, but then must rest for ([0-9]+) seconds./
    [_, name, speed, run_time, rest_time] = Regex.run(regex, String.strip(row))
    %{String.to_atom name =>
        {
          (String.to_integer speed),
          (String.to_integer run_time),
          (String.to_integer rest_time)
        }
      }
  end
end
