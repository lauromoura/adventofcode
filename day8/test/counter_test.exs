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

  # Encoded tests.
  test "Empty string encode" do
    str = load_file("test/empty.txt")
    assert {6, 2} == Counter.count_encode(str)
  end
  test "Simple string encode" do
    str = load_file("test/simple.txt")
    assert {9, 5} == Counter.count_encode(str)
  end
  test "Escaped quote encode" do
    str = load_file("test/escaped_quote.txt")
    assert {16, 10} == Counter.count_encode(str)
  end
  test "Escaped char encode" do
    str = load_file("test/escaped_char.txt")
    assert {11, 6} == Counter.count_encode(str)
  end

  test "Advent of code part 2" do
    {encoded, code} =  Counter.count_file("data/day8.txt", &Counter.count_encode/1)
    assert encoded - code == 2046
  end
end
