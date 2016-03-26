defmodule Counter do

  def code_size(str), do: String.length(str)

  def count_decode(str) do
    {parsed, _} = Code.eval_string(str)
    {code_size(str), String.length(parsed)}
  end

  def count_encode(str) do
    # 2 for the new "" around the string.
    encoded_size = (String.to_char_list(str) |> encode) + 2
    {encoded_size, code_size(str)}
  end

  def encode([?"|tail]), do: encode(tail) + 2
  def encode([?\\|tail]), do: encode(tail) + 2
  def encode([x|tail]), do: encode(tail) + 1
  def encode([]), do: 0

  def count_file(filename, function) do
    stream = File.stream!(filename, [:read])

    Enum.reduce(stream, {0, 0},
      fn str, {code, real} ->
        {row_code, row_real} = function.(String.strip str)
        {row_code + code, row_real + real}
      end)
  end
end