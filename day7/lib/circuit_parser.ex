defmodule CircuitParser do
  @spec parse(binary) :: list
  def lex(str) do
    {:ok, _tokens, _} = str |> to_char_list |> :circuit_lexer.string
  end
  def parse(str) do
    {:ok, tokens, _} = lex(str)
    {:ok, expression} = :circuit_parser.parse(tokens)
    expression
  end
end
