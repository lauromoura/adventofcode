defmodule PasswordTest do
  use ExUnit.Case

  @seed "vzbxkghb"

  test "Invalid password: Forbidden letters" do
    assert not Password.has_no_forbidden_letters("hijklmmn")
  end
  test "Invalid password: Increasing sequence" do
    assert not Password.has_increasing_sequence("abbceffg")
  end
  test "Invalid password: Pair of double letters" do
    assert not Password.has_double_pairs("abceegjk")
  end

  test "Valid password" do
    passwd = "abceezz"
    assert Password.has_no_forbidden_letters(passwd)
    assert Password.has_increasing_sequence(passwd)
    assert Password.has_double_pairs(passwd)
    assert Password.valid(passwd)
  end

  test "Update password" do
    assert "ab" == Password.next("aa", :allow_invalid)
    assert "xy" == Password.next("xx", :allow_invalid)
    assert "xz" == Password.next("xy", :allow_invalid)
    assert "ya" == Password.next("xz", :allow_invalid)
    assert "aaaa" == Password.next("zzzz", :allow_invalid)
  end

  test "Advent of code Day 11 part one" do
    assert "vzbxxyzz" == Password.next(@seed, :enforce)
  end
  test "Advent of code Day 11 part two" do
    assert "vzcaabcc" == Password.next("vzbxxyzz", :enforce)
  end

end
