defmodule Day5 do
  def process_file(file, part), do: process_file(file, part, 0)

  defp process_file(file, part, current) do
    row = IO.read(file, :line)
    if (row != :eof) do
      process_file(file, part, current + process_row(String.strip(row), part))
    else
      current
    end
  end

  defp has_3vowels(row) do
    regex = ~r/[aeiou].*[aeiou].*[aeiou]/
    Regex.match?(regex, row)
  end
  defp has_doubles(row) do
    regex = ~r/([a-z])\1/
    Regex.match?(regex, row)
  end
  defp has_no_forbidden(row) do
    tokens = ["ab", "cd", "pq", "xy"]
    not Enum.any?(Enum.map(tokens, &(String.contains?(row, &1))))
  end

  defp has_double_pair(row) do
    regex = ~r/([a-z])([a-z]).*\1\2/
    Regex.match?(regex, row)
  end
  defp has_repeat(row) do
    regex = ~r/([a-z]).\1/
    Regex.match?(regex, row)
  end

  defp process_row(row, :partone) do
    if has_3vowels(row) and has_doubles(row) and has_no_forbidden(row) do
      1
    else
      0
    end
  end
  defp process_row(row, :parttwo) do
    if has_double_pair(row) and has_repeat(row) do
      1
    else
      0
    end
  end
end


file = File.open!("day5.txt", [:read])
IO.puts(Day5.process_file(file, :partone))
file = File.open!("day5.txt", [:read])
IO.puts(Day5.process_file(file, :parttwo))