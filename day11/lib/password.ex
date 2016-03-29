defmodule Password do

  @range ?z - ?a

  def valid(password) do
    password
    |> has_no_forbidden_letters
    |> has_increasing_sequence
    |> has_double_pairs
  end

  def has_no_forbidden_letters(password) do
    forbidden = [?i, ?o, ?l]
    chars = String.codepoints password
    is_valid = not Enum.any?(chars, fn <<char::utf8>> ->
      char in forbidden
    end)
    {password, is_valid}
  end

  def has_increasing_sequence({_,false}), do: {nil, false}
  def has_increasing_sequence({password, _}) do
    {password, true}
  end

  def has_double_pairs({_, false}), do: false
  def has_double_pairs({password, _}) do
    regex = ~r/.*(\w\w).*(\w\w).*/
    case Regex.run(regex, password) do
      nil -> false
      [_row, pair_a, pair_b] when pair_a != pair_b -> false
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