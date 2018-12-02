defmodule ReindeerTest do
  use ExUnit.Case

  @reindeers %{ :Comet => {14, 10, 127}, :Dancer => {16, 11, 162}}

  def load_specs(filename) do
    filename
    |> File.stream!([:read])
    |> Enum.reduce(%{}, fn row, acc ->
        Map.merge(acc, Reindeer.parse(row))
       end)
  end

  test "Both running test" do
    assert 14 = Reindeer.run(@reindeers, :Comet, 1)
    assert 16 = Reindeer.run(@reindeers, :Dancer, 1)
    assert 140 = Reindeer.run(@reindeers, :Comet, 10)
    assert 160 = Reindeer.run(@reindeers, :Dancer, 10)
  end

  test "One stopped test" do
    assert 140 = Reindeer.run(@reindeers, :Comet, 11)
    assert 176 = Reindeer.run(@reindeers, :Dancer, 11)
  end

  test "Both stopped test" do
    assert 140 = Reindeer.run(@reindeers, :Comet, 13)
    assert 176 = Reindeer.run(@reindeers, :Dancer, 13)
  end

  test "Both after long runs" do
    assert 1120 == Reindeer.run(@reindeers, :Comet, 1000)
    assert 1056 == Reindeer.run(@reindeers, :Dancer, 1000)
  end

  test "Simple winner" do
    assert :Comet == Reindeer.winner(@reindeers, 1000)
  end

  test "Parsing test" do
    assert %{:Comet => {14, 10, 127}} == Reindeer.parse("Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.")
  end

  test "Simple file loading test" do
    reindeers = load_specs("test/sample.txt")
    assert reindeers ==  @reindeers
  end

  test "Part one test" do
    reindeers = load_specs("test/day14.txt")
    winner = Reindeer.winner(reindeers, 2503)
    assert 2660 == Reindeer.run(reindeers, winner, 2503)
  end

  test "Points winner basic example" do
    results = Reindeer.points_race(@reindeers, 1)
    assert 1 == Reindeer.points_winner(results)
    results = Reindeer.points_race(@reindeers, 1000)
    assert 689 == Reindeer.points_winner(results)
  end

  test "Points race basic example" do
    assert %{:Comet => 0, :Dancer => 1} = Reindeer.points_race(@reindeers, 1)
    assert %{:Comet => 312, :Dancer => 689} = Reindeer.points_race(@reindeers, 1000)
  end

  test "Part two test" do
    reindeers = load_specs("test/day14.txt")
    results = Reindeer.points_race(reindeers, 2503)
    assert 1256 == Reindeer.points_winner(results)
  end
end