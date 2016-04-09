defmodule DinnerTable do

  def parse(row) do
    regex = ~r/(\w+) would (gain|lose) ([0-9]+) happiness units by sitting next to (\w+)./
    [_, name, action, delta, target] = Regex.run(regex, String.strip(row))
    delta = String.to_integer delta
    if action == "lose" do
      delta = -delta
    end
    {name, target, delta}
  end

  def max_happiness(interactions) do
    interactions
    |> get_guests
    |> MapSet.to_list
    |> Permutations.of # Fixme. We don't need all permutations, as 1,2,3 is equal to 3,1,2
    |> Enum.map(&(happiness(&1, interactions)))
    |> Enum.max
  end

  def happiness(seating, interactions) do
    seating
    |> neighbours
    |> Enum.map(fn {guest, left, right} ->
      interactions[{guest, left}] + interactions[{guest, right}]
    end)
    |> Enum.sum
  end

  def neighbours(seating) do
    max_idx = Enum.count(seating)
    seating
    |> Enum.with_index
    |> Enum.map(fn {guest, idx} -> 
      {guest, Enum.at(seating, idx - 1), Enum.at(seating, rem(idx + 1, max_idx))}
    end)
  end

  def get_guests(interactions) do
    Enum.reduce(Map.keys(interactions), %MapSet{},
      fn {guest, _}, acc ->
        MapSet.put(acc, guest)
      end)
  end

  def add_myself_with(guest, interactions) do
    interactions
    |> Map.put({guest, "myself"}, 0)
    |> Map.put({"myself", guest}, 0)
  end

  def add_myself(interactions) do
    interactions
    |> get_guests
    |> Enum.reduce(interactions, &add_myself_with/2)
  end
end