defmodule JsonCounterTest do
  use ExUnit.Case

  test "Simple list" do
    assert 6 == JsonCounter.count('[1,2,3]')
  end
  test "Simple dict" do
    assert 6 == JsonCounter.count('{"a":2,"b":4}')
  end
  test "Nested list" do
    assert 3 == JsonCounter.count('[[[3]]]')
  end
  test "Nested dict" do
    assert 3 == JsonCounter.count('{"a":{"b":4},"c":-1}')
  end
  test "List inside dict" do
    assert 0 == JsonCounter.count('{"a":[-1,1]}')
  end
  test "Dict inside list" do
    assert 0 == JsonCounter.count('[-1,{"a":1}]')
  end
  test "Empty list" do
    assert 0 == JsonCounter.count('[]')
  end
  test "Empty dict" do
    assert 0 == JsonCounter.count('{}')
  end

  test "Advent of code part 1" do
    assert 119433 == JsonCounter.count_file("test/day12.json")
  end
end
