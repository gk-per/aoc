defmodule AdventOfCode.Day2 do
  @moduledoc """
  Documentation for `AdventOfCode.Day2`.
  """

  @doc """
  Day 2 of Advent of Code. Rock paper scissors tournament.

  ## Examples


  """
  def part_one() do
    total_shape_score =
      isolate_individual_rounds()
      |> Enum.map(fn x -> List.last(String.split(x)) end)
      |> Enum.map(fn x -> map_xyz_to_number(x) end)
      |> Enum.sum()

    total_wl_score =
      isolate_individual_rounds()
      |> Enum.map(fn x -> String.split(x) end)
      |> Enum.map(fn x -> win_or_lose_or_draw(x) end)
      |> Enum.sum()

    total_shape_score + total_wl_score
  end

  def part_two() do
    isolate_individual_rounds()
    |> Enum.map(fn x -> String.split(x) end)
    |> Enum.map(fn x -> make_pick_based_on_second_column(x) end)
    |> Enum.sum()
  end

  defp isolate_individual_rounds() do
    "lib/input.txt"
    |> File.read!()
    |> String.split("\n")
  end

  defp map_xyz_to_number(x) do
    case x do
      "X" -> 1
      "Y" -> 2
      "Z" -> 3
    end
  end

  defp win_or_lose_or_draw(x) do
    [their_pick, my_pick] = x
    # Y beats A, loses to C
    # X beats C, loses to B
    # Z beats B, loses to A
    cond do
      # win
      (their_pick == "A" and my_pick == "Y") or (their_pick == "B" and my_pick == "Z") or
          (their_pick == "C" and my_pick == "X") ->
        6

      # lose
      (their_pick == "A" and my_pick == "Z") or (their_pick == "B" and my_pick == "X") or
          (their_pick == "C" and my_pick == "Y") ->
        0

      # draw
      true ->
        3
    end
  end

  defp make_pick_based_on_second_column(x) do
    # X means lose
    # Y means draw
    # Z means win
    [their_pick, my_pick] = x

    case my_pick do
      "X" -> 0 + my_pick_to_points(pick_loser(their_pick))
      "Y" -> 3 + my_pick_to_points(their_pick)
      "Z" -> 6 + my_pick_to_points(pick_winner(their_pick))
    end
  end

  defp pick_winner(x) do
    case x do
      "A" -> "Y"
      "B" -> "Z"
      "C" -> "X"
    end
  end

  defp pick_loser(x) do
    case x do
      "A" -> "Z"
      "B" -> "X"
      "C" -> "Y"
    end
  end

  defp my_pick_to_points(x) do
    case x do
      # "X" or "A" -> 1
      # "Y" or "B" -> 2
      # "Z" or "C" -> 3
      x when x in ["X", "A"] -> 1
      x when x in ["Y", "B"] -> 2
      x when x in ["Z", "C"] -> 3
    end
  end
end
