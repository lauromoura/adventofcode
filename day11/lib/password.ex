defmodule Password do

  @moduledoc """
  Password generator for day 11 of advent of code.
  """

  @range ?z - ?a

  def valid(password) do
    checks = [&has_no_forbidden_letters/1,
              &has_increasing_sequence/1,
              &has_double_pairs/1]
    Enum.all?(Enum.map(checks, &(&1.(password))))
  end

  def has_no_forbidden_letters(password) do
    forbidden = [?i, ?o, ?l]
    chars = String.codepoints password
    not Enum.any?(chars, fn <<char::utf8>> ->
      char in forbidden
    end)
  end

  def has_increasing_sequence(password) do
    increasing_triplet(String.to_char_list(password))
  end

  def increasing_triplet(arg = [a, b, c|tail]) do
    if a + 2 == c and b + 1 == c do
      true
    else
      increasing_triplet([b, c | tail])
    end
  end
  def increasing_triplet(_), do: false

  def has_double_pairs(password) do
    regex = ~r/.*(\w)(\1).*(\w)(\3).*/
    case Regex.run(regex, password) do
      nil -> false
      [_row, a1, _, a3, _] when a1 == a3 -> false
      _ -> true
    end
  end

  def next(password, :allow_invalid) do
    password
    |> String.codepoints
    |> encode
    |> increment()
    |> decode()
    |> to_string
  end
  def next(password, :enforce) do
    newpass = next(password, :allow_invalid)
    if valid(newpass) do
      newpass
    else
      next(newpass, :enforce)
    end
  end

  def encode(characters) do
    Enum.map(characters, fn <<char::utf8>> -> char - ?a end)
  end

  def decode(characters) do
    Enum.map(characters, fn char -> char + ?a end)
  end

  def increment([]) do
    []
  end
  def increment(sequence) do
    [head|tail] = increment_helper(sequence)
    if head > @range do
      head = 0
    end
    [head|tail]
  end

  def increment_helper([head]) do
    [head + 1]
  end
  def increment_helper([head|tail]) do
    [previous | tail] = increment_helper(tail)
    if previous > @range do
      previous = 0
      head = head + 1
    end
    [head, previous | tail]
  end
end
