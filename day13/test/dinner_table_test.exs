defmodule DinnerTableTest do
  use ExUnit.Case

  defp load_specs(filename) do
    filename
    |> File.stream!([:read])
    |> Enum.reduce(%{}, fn row, acc ->
      interaction = DinnerTable.parse(row)
      %Interaction{name: name, target: target} = interaction
      Map.put(acc, {name, target}, interaction)
    end)
  end

  test "Parse test" do
    interaction = DinnerTable.parse("Anna would gain 42 happiness units by sitting next to Apu.")
    assert %Interaction{name: "Anna", target: "Apu", delta: 42} == interaction
  end
  test "Parse test negative delta" do
    interaction = DinnerTable.parse("Anna would lose 120 happiness units by sitting next to Apu.")
    assert %Interaction{name: "Anna", target: "Apu", delta: -120} == interaction
  end

  test "Example test" do
    example_data = load_specs("test/example.txt")
    assert 330 = DinnerTable.max_happiness(example_data)
  end
end