defmodule CircuitRunner do
  use Bitwise
  require CircuitParser

  def main([filename, output|_]) do
    circuit = parse_file(filename)
    {circuit, value} = get_gate(circuit, String.to_atom(output))
    IO.inspect(value)
  end

  def main([filename|_]) do
    IO.puts("No output gate. Defaulting to 'a'")
    main([filename, "a"])
  end
  def main([]) do
    IO.puts("No arguments. Defaulting to day7.txt and gate 'a'")
    main(["day7.txt", "a"])
  end

  defp parse_file(filename), do: parse_file(File.open!(filename, [:read]), Map.new)

  defp parse_file(file, acc) do
    row = IO.read(file, :line)
    if (row != :eof) do
      parsed_row = CircuitParser.parse(to_char_list(String.strip(row)))
      parse_file(file, parse_row(parsed_row, acc))
    else
      acc
    end
  end

  defp parse_row(row={gate, operation}, acc) do
    Map.put(acc, gate, operation)
  end

  defp update(circuit, gate, _value) when is_integer(gate), do: circuit
  defp update(circuit, gate, value) do
    Map.update!(circuit, gate, fn _ -> value end)
  end

  defp get_gate(circuit, gate) when is_atom(gate) do
    # IO.inspect(gate)
    operation = Map.get(circuit, gate)
    case operation do
      {:'->', a} ->
        {circuit, value} = get_gate(circuit, a)
        {update(circuit, a, value), value}
      {:AND, a, b} ->
        {circuit, value_a} = get_gate(circuit, a)
        circuit = update(circuit, a, value_a)
        {circuit, value_b} = get_gate(circuit, b)
        circuit = update(circuit, b, value_b)
        value = band(value_a, value_b)
        {circuit, value}
      {:OR, a, b} ->
        {circuit, value_a} = get_gate(circuit, a)
        circuit = update(circuit, a, value_a)
        {circuit, value_b} = get_gate(circuit, b)
        circuit = update(circuit, b, value_b)
        value = bor(value_a, value_b)
        {circuit, value}
      {:RSHIFT, a, b} ->
        {circuit, value_a} = get_gate(circuit, a)
        circuit = update(circuit, a, value_a)
        {circuit, value_b} = get_gate(circuit, b)
        circuit = update(circuit, b, value_b)
        value = bsr(value_a, value_b)
        {circuit, value}
      {:LSHIFT, a, b} ->
        {circuit, value_a} = get_gate(circuit, a)
        circuit = update(circuit, a, value_a)
        {circuit, value_b} = get_gate(circuit, b)
        circuit = update(circuit, b, value_b)
        value = bsl(value_a, value_b)
        {circuit, value}
      {:NOT, a} ->
        {circuit, value} = get_gate(circuit, a)
        circuit = update(circuit, a, value)
        {circuit, bnot(value)}
      value ->
        {circuit, value}
    end
  end
  defp get_gate(circuit, gate) when is_integer(gate), do: {circuit, gate}
end
