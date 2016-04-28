defmodule Sue do

  def unretroencabulate(key, hint, candidate) do
    cond do
      key in [:cats, :trees] ->
        if candidate > hint do
          hint
        else
          -hint
        end
      key in [:pomeranians, :goldfish] ->
        if candidate < hint do
          hint
        else
          -hint
        end
      true ->
        candidate
    end
  end

  def find(sues, hint, retroencabulated \\ :normal) do
    sues
    |> Enum.find(fn {key, value} -> 
          updated = Map.merge(hint, value, fn key, v1, v2 ->
            if retroencabulated == :retroencabulated do
              unretroencabulate(key, v1, v2)
            else
              v2
            end
          end)
          Map.equal?(hint, updated)
        end)
    |> elem(0)
  end

  def parse(row) do
    regex = ~r/Sue ([0-9]+): (\w+): ([0-9]+), (\w+): ([0-9]+), (\w+): ([0-9]+)/
    [_, number, feature1, value1, feature2, value2, feature3, value3] = Regex.run(regex, String.strip(row))
    sue = %{
      (String.to_atom feature1) => (String.to_integer value1),
      (String.to_atom feature2) => (String.to_integer value2),
      (String.to_atom feature3) => (String.to_integer value3),
    }
    {(String.to_integer number), sue}
  end
end