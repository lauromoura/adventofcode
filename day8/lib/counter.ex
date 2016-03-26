defmodule Counter do
  def count(str) do
    code_size = String.length(str)
    {parsed, _} = Code.eval_string(str)
    {code_size, String.length(parsed)}
  end

  def count_file(filename) do
    stream = File.stream!(filename, [:read])

    Enum.reduce(stream, {0, 0},
      fn str, {code, real} ->
        {row_code, row_real} = count(String.strip str)
        {row_code + code, row_real + real}
      end)
  end
end