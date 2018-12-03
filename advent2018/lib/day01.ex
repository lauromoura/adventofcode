defmodule Day01 do
  def frequency(changes) do
    changes
    |> parse_changes
    |> Enum.sum()
  end

  def repeated(changes) do
    changes
    |> parse_changes
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn f, {s, freqs} ->
      new = f + s

      if MapSet.member?(freqs, new) do
        {:halt, new}
      else
        {:cont, {new, MapSet.put(freqs, new)}}
      end
    end)
  end

  defp parse_changes(changes) do
    changes
    |> Enum.map(&String.to_integer/1)
  end
end
