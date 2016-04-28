defmodule Sue do

  def find(sues, hint) do
    sues
    |> Enum.find(fn {key, value} -> 
          MapSet.subset?(value, hint)
        end)
    |> elem(0)
  end

  def parse(row) do
    regex = ~r/Sue ([0-9]+): (\w+): ([0-9]+), (\w+): ([0-9]+), (\w+): ([0-9]+)/
    [_, number, feature1, value1, feature2, value2, feature3, value3] = Regex.run(regex, String.strip(row))
    sue = MapSet.new(%{
      (String.to_atom feature1) => (String.to_integer value1),
      (String.to_atom feature2) => (String.to_integer value2),
      (String.to_atom feature3) => (String.to_integer value3),
    })
    {(String.to_integer number), sue}
  end
end