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

  test "basic question 2" do
    boxes = [
      "abcde",
      "fghij",
      "klmno",
      "pqrst",
      "fguij",
      "axcye",
      "wvxyz"
    ]

    assert Day02.common_letters(boxes) == "fgij"
  end

  test "question 2" do
    common =
      "test/day02_1_input.txt"
      |> File.stream!([], :line)
      |> Stream.map(&String.trim/1)
      |> Day02.common_letters()

    assert common == "srijafjzloguvlntqmphenbkd"
  end
end
