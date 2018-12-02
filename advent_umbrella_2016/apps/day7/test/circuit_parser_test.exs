defmodule CircuitParserTest do
  use ExUnit.Case
  doctest CircuitParser

  test "Number lexer" do
    {:ok, [{:number, 1, 42}], _} = CircuitParser.lex("42")
  end

  test "identifier lexer" do
    {:ok, [{:identifier, 1, :ab}], _} = CircuitParser.lex("ab")
    {:ok, [{:identifier, 1, :a}], _} = CircuitParser.lex("a")
  end

  test "Unary operator lexer" do
    {:ok, [{:unaryop, 1, :NOT}], _} = CircuitParser.lex("NOT")
  end

  test "Binary operator lexer" do
    {:ok, [{:binaryop, 1, :AND}], _} = CircuitParser.lex("AND")
    {:ok, [{:binaryop, 1, :OR}], _} = CircuitParser.lex("OR")
    {:ok, [{:shiftop, 1, :RSHIFT}], _} = CircuitParser.lex("RSHIFT")
    {:ok, [{:shiftop, 1, :LSHIFT}], _} = CircuitParser.lex("LSHIFT")
  end

  test "Assignment operator lexer" do
    {:ok, [{:"->", 1}], _} = CircuitParser.lex("->")
  end

  test "Whole expressions lexer" do
    {:ok, [{:identifier, 1, :a},
           {:binaryop, 1, :AND},
           {:identifier, 1, :b},
           {:"->", 1},
           {:identifier, 1, :cd}], _} = CircuitParser.lex("a AND b -> cd")
  end

  test "Wrong input lexer" do
    assert_raise MatchError, fn ->
      CircuitParser.lex("ANDD")
    end
  end

  test "Parser test" do
    {:ab,  {:NOT, :a}} = CircuitParser.parse("NOT a -> ab")
    {:e, {:AND, 1, :cd}} = CircuitParser.parse("1 AND cd -> e")
    {:g, {:RSHIFT, :ef, 44}} = CircuitParser.parse("ef RSHIFT 44 -> g")
  end
end
