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
