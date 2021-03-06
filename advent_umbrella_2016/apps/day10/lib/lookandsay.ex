defmodule LookAndSay do

  @moduledoc """
  Implements the Look-and-Say sequence for strings.
  """

  def say(amount) do
    chars = [head | _tail] = String.to_char_list(amount)
    chars
    |> say_count(head, 0)
    |> List.to_string
  end

  defp say_count([current|tail], current, current_count) do
    say_count(tail, current, current_count + 1)
  end
  defp say_count([new|tail], current, current_count) do
    [(to_char_list current_count), current] ++ say_count(tail, new, 1)
  end
  defp say_count([], current, current_count) do
    [(to_char_list current_count), current]
  end
end
