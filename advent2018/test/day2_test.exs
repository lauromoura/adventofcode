defmodule Day02Test do
  use ExUnit.Case

  test "basic tests" do
    boxes = [
      "abcdef",
      "bababc",
      "abbcde",
      "abcccd",
      "aabcdd",
      "abcdee",
      "ababab"
    ]

    assert Day02.checksum(boxes) == 12
  end

  test "question 1" do
    checksum =
      "test/day02_1_input.txt"
      |> File.stream!([], :line)
      |> Stream.map(&String.trim/1)
      |> Day02.checksum()

    assert checksum == 6944
  end
end
