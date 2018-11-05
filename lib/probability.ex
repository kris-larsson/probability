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
    count * 100.0 / iterations |> Float.round(5)
  end

  defp display_result(rm, i) do
    IO.puts "0 correct: #{Map.get(rm, 0)}, #{get_percent(rm, 0, i)}%"
    IO.puts "1 correct: #{Map.get(rm, 1)}, #{get_percent(rm, 1, i)}%"
    IO.puts "2 correct: #{Map.get(rm, 2)}, #{get_percent(rm, 2, i)}%"
    IO.puts "3 correct: #{Map.get(rm, 3)}, #{get_percent(rm, 3, i)}%"
    IO.puts "4 correct: #{Map.get(rm, 4)}, #{get_percent(rm, 4, i)}%"
    IO.puts "5 correct: #{Map.get(rm, 5)}, #{get_percent(rm, 5, i)}%"
    IO.puts "6 correct: #{Map.get(rm, 6)}, #{get_percent(rm, 6, i)}%"
  end

  def start(iterations \\ 10000000) do
    start_time = DateTime.utc_now()
    IO.puts "Running #{iterations} iterations"
    result_map = Enum.reduce(1..iterations, %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0}, fn(_i, acc) ->
      Map.update!(acc, run_six(), &(&1 + 1))
    end)
    display_result(result_map, iterations)
    DateTime.diff(DateTime.utc_now(), start_time, :millisecond)
  end
end
