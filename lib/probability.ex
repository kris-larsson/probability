defmodule Probability do
  @moduledoc """
  Documentation for Probability.
  """

  defp check(answer) do
    answer == Enum.random(1..3)
  end

  defp run_six do
    Enum.reduce(1..6, 0, fn(_, acc) ->
      case check(Enum.random(1..3)) do
        true -> acc + 1
        false -> acc
      end
    end)
  end

  defp get_percent(rm, correct, iterations) do
    count = Map.get(rm, correct)
    count * 100.0 / iterations |> Float.round(3)
  end

  def start(iterations \\ 10000000) do
    start_time = DateTime.utc_now()
    IO.puts "Running #{iterations} iterations"
    result_map = Enum.reduce(1..iterations, %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0}, fn(_i, acc) ->
      Map.update!(acc, run_six(), &(&1 + 1))
    end)
    Enum.each(0..6, fn i ->
      IO.puts "#{i} correct: #{Map.get(result_map, i)}, #{get_percent(result_map, i, iterations)}%"
    end)
    DateTime.diff(DateTime.utc_now(), start_time, :millisecond)
  end
end
