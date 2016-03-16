defmodule Day4 do
  def mine(key), do: mine(key, 0)

  def mine(key, suffix) do
    candidate = key <> Integer.to_string(suffix)
    hash = :crypto.hash(:md5, candidate) |> Base.encode16
    case hash do
      <<"000000", _tail::binary >> ->
        suffix
      _x -> mine(key, suffix + 1)
    end
  end
end

IO.puts(Day4.mine("yzbqklnj"))