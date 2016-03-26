defmodule CounterTest do
  use ExUnit.Case
  doctest Counter

  defp load_file(filename) do
    file = File.open!(filename, [:read])
    IO.read(file, :line)
  end

  test "Empty string" do
    str = load_file("test/empty.txt")
    assert {2, 0} == Counter.count_decode(str)
  end
  test "Simple string" do
    str = load_file("test/simple.txt")
    assert {5, 3} == Counter.count_decode(str)
  end
  test "Escaped quote" do
    assert {10, 7} == Counter.count_file("test/escaped_quote.txt", &Counter.count_decode/1)
  end
  test "Escaped char" do
    assert {6, 1} == Counter.count_file("test/escaped_char.txt", &Counter.count_decode/1)
  end

  test "Advent of code part 1" do
    {code, real} =  Counter.count_file("data/day8.txt", &Counter.count_decode/1)
    assert code - real == 1333
  end
end
