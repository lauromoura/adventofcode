defmodule CircuitRunnerTest do
  use ExUnit.Case
  use Bitwise
  doctest CircuitRunner

  import ExUnit.CaptureIO

  defp run_test(filename, token, expected) do
    assert capture_io(fn ->
      CircuitRunner.main([filename, token,])
    end) == "#{expected}\n"
  end

  test "CLI parsing acceptance test" do
    filename = "test/runner_example_circuit.txt"
    a = 1
    run_test(filename, "a", a)
    b = bsl(a, 4)
    run_test(filename, "b", b)
    c = bor(a, b)
    run_test(filename, "c", c)
    d = bnot(c)
    run_test(filename, "d", d)
    e = d
    run_test(filename, "e", e)
  end

  test "Actual day7 test part one" do
    run_test("data/day7.txt", "a", 956)
  end
  test "Actual day7 test part two" do
    run_test("data/day7b.txt", "a", 40149)
  end
end
