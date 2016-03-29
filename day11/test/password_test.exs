defmodule PasswordTest do
  use ExUnit.Case

  @seed "vzbxkghb"

  test "Valid password: Forbidden letters" do
    assert not Password.valid("hijklmmn")
  end

  @tag skip: true
  test "Valid password: Increasing sequence" do
    assert not Password.valid("abbceffg")
  end
  test "Valid password: Pair of double letters" do
    assert not Password.valid("abbcegjk")
  end

  test "Update password" do
    assert "ab" == Password.next("aa", :allow_invalid)
    assert "xy" == Password.next("xx", :allow_invalid)
    assert "xz" == Password.next("xy", :allow_invalid)
    assert "ya" == Password.next("xz", :allow_invalid)
    assert "aaaa" == Password.next("zzzz", :allow_invalid)
  end

  @tag skip: true
  test "Advent of code Day 11 part one" do
    assert "a" == Password.next(@seed, :enforce)
  end
end