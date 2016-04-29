defmodule Eggnog do

  # Combination code from Stack Overflow 30585697
  def combination(0, _), do: [[]]
  def combination(_, []), do: []
  def combination(n, [x|xs]) do
    (for y <- combination(n - 1, xs), do: [x|y]) ++ combination(n, xs)
  end

  def options(quantity, buckets) do
    Enum.sum (for seq_size <- 1..(Enum.count buckets) do
      seq_size
      |> combination(buckets)
      |> Enum.filter(fn x -> Enum.sum(x) == quantity end)
      |> Enum.count
    end)
  end
end