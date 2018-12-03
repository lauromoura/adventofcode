defmodule Day01Test do
  use ExUnit.Case

  test "basic tests" do
    assert Day01.frequency(["+1", "-2", "+3", "+1"]) == 3
    assert Day01.frequency(["+1", "+1", "+1"]) == 3
    assert Day01.frequency(["+1", "+1", "-2"]) == 0
    assert Day01.frequency(["-1", "-2", "-3"]) == -6
  end

  test "question 1" do
    freq =
      "test/day01_1_input.txt"
      |> File.stream!([], :line)
      |> Stream.map(&String.trim/1)
      |> Day01.frequency()

    assert freq == 518
  end

  test "basic part two" do
    frequencies = ["+1", "-2", "+3", "+1"]
    assert Day01.repeated(frequencies) == 2
  end

  test "question 2" do
    freq =
      "test/day01_1_input.txt"
      |> File.stream!([], :line)
      |> Stream.map(&String.trim/1)
      |> Day01.repeated()

    assert freq == 72889
  end
end
