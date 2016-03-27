defmodule LookAndSayTest do
  use ExUnit.Case

  @seed "1321131112"

  test "1", do: assert "11" == LookAndSay.say("1")
  test "11", do: assert "21" == LookAndSay.say("11")
  test "21", do: assert "1211" == LookAndSay.say("21")
  test "1211", do: assert "111221" == LookAndSay.say("1211")
  test "111221", do: assert "312211" == LookAndSay.say("111221")
  test "Tens", do: assert "101" == LookAndSay.say("1111111111")

  defp iterate_say(count) do
    Enum.reduce(1..count, @seed, fn _, acc -> LookAndSay.say(acc) end)
  end

  test "Advent part 1" do
    size = iterate_say(40)
           |> String.length
    assert 492982 == size
  end
  test "Advent part 2" do
    size = iterate_say(50)
           |> String.length
    assert 6989950 == size
  end
end
