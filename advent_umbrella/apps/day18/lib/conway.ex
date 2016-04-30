defmodule Conway do

  @living_cell ?#
  @dead_cell ?.

  def evolve(grid, 0) do
    # print(grid)
    grid
  end
  def evolve(grid, n) do
    evolve(iterate(grid), n-1)
  end

  def iterate(grid) do
    # print(grid)
    Enum.reduce(grid, %{}, fn {coord, v}, acc ->
      Map.put(acc, coord, next_cell_value(coord, v, grid))
    end)
  end

  def next_cell_value(coord={r,c}, v, grid) do
    neighbours = living_neighbours(coord, grid)
    case v do
      true -> neighbours >= 2 and neighbours <= 3
      false -> neighbours == 3
    end
  end

  def how_many_living?(grid) do
    grid
    |> Map.values
    |> Enum.filter(fn v -> v end)
    |> Enum.count
  end

  def living?(cell), do: cell == @living_cell

  def translate(true), do: << @living_cell :: utf8 >>
  def translate(false), do: << @dead_cell :: utf8 >>

  def living_neighbours(coord, grid) do
    # IO.inspect(coord)
    coord
    |> neighbours
    # |> IO.inspect
    |> Enum.filter(fn neighbour -> Map.get(grid, neighbour) == true end)
    |> Enum.count
  end

  def neighbours({r, c}) do
    for r_idx <- (r-1)..(r+1), c_idx <- (c-1)..(c+1),
        r_idx >= 0, c_idx >= 0, (r_idx != r or c_idx != c) do
      {r_idx, c_idx}
    end
  end

  def print(grid) do
    {rows, cols} = dimensions(grid)

    for row <- 0..rows do
      for col <- 0..cols do
        grid
        |> Map.get({row, col})
        |> translate
        |> IO.write
      end
      IO.puts("")
    end
  end

  def dimensions(grid) do
    {rows, cols} = grid
    |> Map.keys
    |> Enum.unzip

    {Enum.max(rows), Enum.max(cols)}
  end

end