defmodule SueTest do
  use ExUnit.Case

  @hint %{:children => 3, :cats => 7, :samoyeds => 2, :pomeranians => 3,
            :akitas => 0, :vizslas => 0, :goldfish => 5, :trees => 3,
            :cars => 2, :perfumes => 1}

  defp load_specs(filename) do
    filename
    |> File.stream!([:read])
    |> Enum.reduce(%{}, fn row, acc ->
        {number, sue} = Sue.parse(row)
        Map.put(acc, number, sue)
      end)
  end

  test "Advent part 1" do
    sues = load_specs("test/day16.txt")
    assert 213 == Sue.find(sues, @hint)
  end

  test "Advent part 2" do
    sues = load_specs("test/day16.txt")
    assert 323 == Sue.find(sues, @hint, :retroencabulated)
  end
end