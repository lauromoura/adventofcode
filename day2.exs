defmodule Day2 do
  def process_file(file), do: process_file(file, 0)

  defp process_file(file, current) do
    row = IO.read(file, :line)
    if (row != :eof) do
      process_file(file, current + process_row(String.strip(row)))
    else
      current
    end
  end

  defp process_row(row) do
    [l, w, h] = String.split(row, "x") |> (Enum.map &String.to_integer/1)
    # From 1st part of day 2
    # sides = [l*w, w*h, h*l]
    # smallest = Enum.min(sides)
    # Enum.sum(Enum.map(sides, &(2*&1))) + smallest
    smallest = Enum.sort([l,w,h]) |> Enum.take(2)
    volume = Enum.reduce([l,w,h], &(&1*&2))
    volume + (Enum.map(smallest, &(2*&1)) |> Enum.sum)
  end
end

file = File.open!("day2.txt", [:read])

IO.puts(Day2.process_file(file))