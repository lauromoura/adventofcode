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

  defp get_operand_values(circuit, operands) do
    Enum.reduce(Enum.reverse(operands), {circuit, []},
      fn (operand, {circuit, operand_values}) ->
        {circuit, value} = get_gate(circuit, operand)
        circuit = update(circuit, operand, value) # Memoize operand value
        {circuit, [value | operand_values]}
      end)
  end

  defp get_func(opcode) do
    case opcode do
      :AND -> &band/2
      :OR -> &bor/2
      :RSHIFT -> &bsr/2
      :LSHIFT -> &bsl/2
      :'->' -> &(&1)
      :NOT -> &bnot/1
    end
  end

  # Returns {circuit, value} with the memoized values for each operand gate and the
  # value of the current gate
  defp get_gate(circuit, gate) when is_atom(gate) do
    gate_value = Map.get(circuit, gate)
    if is_integer(gate_value) do
      {circuit, gate_value} # Got a memoized value
    else
      [opcode | operands] = Tuple.to_list(gate_value)
      {circuit, operand_values} = get_operand_values(circuit, operands)
      value = apply(get_func(opcode), operand_values)
      {circuit, value}
    end
  end
  defp get_gate(circuit, gate) when is_integer(gate), do: {circuit, gate}
end
