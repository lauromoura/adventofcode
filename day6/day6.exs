defmodule Day5 do
  def process_file(file), do: process_file(file, Map.new())

  defp process_file(file, current) do
    row = IO.read(file, :line)
    if (row != :eof) do
      parsed_row = parse_row(String.strip(row))
      process_file(file, process_row(parsed_row, current))
    else
      Enum.sum(Map.values(current))
    end
  end

  defp parse_row(row) do
    regex = ~r/(.*) (\d+),(\d+) through (\d+),(\d+)/
    [_row, ops | coords] = Regex.run(regex, row)
    operation = String.to_atom(ops)
    coords = Enum.map(coords, &String.to_integer(&1))
    [operation | coords]
  end

  defp process_row([operation, x0, y0, x1, y1], current) do
    func = case operation do
      :toggle -> fn x -> x+2 end
      :"turn on" -> fn x -> x+1 end
      :"turn off" -> fn x -> max(x-1, 0) end
    end
    coords = for x <- x0..x1, y <- y0..y1 do
      {x, y}
    end
    Enum.reduce coords, current, fn coord, data ->
      data = Map.put_new(data, coord, 0)
      Map.update!(data, coord, func)
    end
  end
end


file = File.open!("day6.txt", [:read])
IO.puts(Day5.process_file(file))
#file = File.open!("day5.txt", [:read])
#IO.puts(Day5.process_file(file, :parttwo))