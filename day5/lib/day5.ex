defmodule AdventOfCode.Day5 do
  @moduledoc """
  Documentation for `AdventOfCode.Day4`.
  """

  @doc """


  ## Examples

                  [M]     [V]     [L]
  [G]             [V] [C] [G]     [D]
  [J]             [Q] [W] [Z] [C] [J]
  [W]         [W] [G] [V] [D] [G] [C]
  [R]     [G] [N] [B] [D] [C] [M] [W]
  [F] [M] [H] [C] [S] [T] [N] [N] [N]
  [T] [W] [N] [R] [F] [R] [B] [J] [P]
  [Z] [G] [J] [J] [W] [S] [H] [S] [G]
  1   2   3   4   5   6   7   8   9


  """
  def part_one() do
    chart = [
      [:dummy],
      ["Z", "T", "F", "R", "W", "J", "G"],
      ["G", "W", "M"],
      ["J", "N", "H", "G"],
      ["J", "R", "C", "N", "W"],
      ["W", "F", "S", "B", "G", "Q", "V", "M"],
      ["S", "R", "T", "D", "V", "W", "C"],
      ["H", "B", "N", "C", "D", "Z", "G", "V"],
      ["S", "J", "N", "M", "G", "C"],
      ["G", "P", "N", "W", "C", "J", "D", "L"]
    ]

    everything =
      read_in_and_split()
      |> List.flatten()
      |> Enum.split(10)

    {_crates, instructions} = everything

    instructions
    |> Enum.map(fn x -> String.replace(x, ~r/[^\d]/, " ") |> String.split() end)
    |> setup_move(chart)
  end

  def part_two() do
    chart = [
      [:dummy],
      ["Z", "T", "F", "R", "W", "J", "G"],
      ["G", "W", "M"],
      ["J", "N", "H", "G"],
      ["J", "R", "C", "N", "W"],
      ["W", "F", "S", "B", "G", "Q", "V", "M"],
      ["S", "R", "T", "D", "V", "W", "C"],
      ["H", "B", "N", "C", "D", "Z", "G", "V"],
      ["S", "J", "N", "M", "G", "C"],
      ["G", "P", "N", "W", "C", "J", "D", "L"]
    ]

    everything =
      read_in_and_split()
      |> List.flatten()
      |> Enum.split(10)

    {_crates, instructions} = everything

    instructions
    |> Enum.map(fn x -> String.replace(x, ~r/[^\d]/, " ") |> String.split() end)
    |> IO.inspect(label: "prefunction")
    |> setup_move_multigrab(chart)
  end

  defp setup_move_multigrab(instructions, chart) do
    IO.inspect("-------")
    IO.inspect(chart, label: "updated chart")

    if Enum.count(instructions) != 0 do
      how_many =
        Enum.at(instructions, 0)
        |> Enum.at(0)
        |> String.to_integer()
        |> IO.inspect(label: "how many")

      from =
        Enum.at(instructions, 0)
        |> Enum.at(1)
        |> String.to_integer()
        |> IO.inspect(label: "from")

      to =
        Enum.at(instructions, 0)
        |> Enum.at(2)
        |> String.to_integer()
        |> IO.inspect(label: "to")

      being_moved =
        Enum.at(chart, from)
        |> Enum.take(-how_many)
        |> IO.inspect(label: "being moved")

      cond do
        how_many == 0 ->
          IO.inspect("Finished with this line")

          {_popped, instructions} =
            instructions
            |> List.pop_at(0)

          IO.inspect(instructions, label: "instructions at 0")
          setup_move_multigrab(instructions, chart)

        how_many > 0 ->
          IO.inspect("remaining > 0")

          chart_row =
            Enum.at(chart, to)
            |> IO.inspect(label: "update chart")

          new_chart_row = chart_row ++ being_moved
          IO.inspect(chart_row, label: "chart_row")

          from_chart_row =
            Enum.at(chart, from)
            |> IO.inspect(label: "from chart row")

          IO.inspect(from_chart_row -- being_moved, label: "subtraction")

          chart =
            chart
            |> List.replace_at(to, new_chart_row)
            |> IO.inspect(label: "replace to row")

          new_from_chart_row = Enum.drop(from_chart_row, -how_many)
          chart =
            chart
            |> List.replace_at(from, new_from_chart_row)
            |> IO.inspect(label: "replace from row")

          instructions_subtracted =
            instructions
            |> List.first()
            |> List.first()
            |> String.to_integer()
            |> IO.inspect(label: "instructions subtracted")

          new_instruction =
            instructions
            |> List.first()
            |> List.replace_at(0, Integer.to_string(0))
            |> IO.inspect(label: "updated instructions")

          instructions =
            List.replace_at(instructions, 0, new_instruction)
            |> IO.inspect(label: "updated instructions in full")

          setup_move_multigrab(instructions, chart)
      end
    else
      IO.inspect(chart, label: "final chart")
    end
  end

  defp setup_move(instructions, chart) do
    IO.inspect("-------")
    IO.inspect(chart, label: "updated chart")

    if Enum.count(instructions) != 0 do
      how_many =
        Enum.at(instructions, 0)
        |> Enum.at(0)
        |> String.to_integer()
        |> IO.inspect(label: "how many")

      from =
        Enum.at(instructions, 0)
        |> Enum.at(1)
        |> String.to_integer()
        |> IO.inspect(label: "from")

      to =
        Enum.at(instructions, 0)
        |> Enum.at(2)
        |> String.to_integer()
        |> IO.inspect(label: "to")

      {being_moved, remaining} =
        Enum.at(chart, from)
        |> IO.inspect(label: "before pop list")
        |> List.pop_at(-1)
        |> IO.inspect(label: "pop list")

      cond do
        how_many == 0 ->
          IO.inspect("Finished with this line")

          {_popped, instructions} =
            instructions
            |> List.pop_at(0)

          IO.inspect(instructions)
          setup_move(instructions, chart)

        how_many > 0 ->
          IO.inspect("remaining > 0")
          IO.inspect(Enum.count(remaining), label: "count remaining")

          chart_row =
            Enum.at(chart, to)
            |> List.insert_at(-1, being_moved)
            |> IO.inspect(label: "update chart")

          chart = List.replace_at(chart, to, chart_row) |> List.replace_at(from, remaining)

          instructions_subtracted =
            instructions
            |> List.first()
            |> List.first()
            |> String.to_integer()
            |> IO.inspect(label: "instructions subtracted")

          new_instruction =
            instructions
            |> List.first()
            |> List.replace_at(0, Integer.to_string(how_many - 1))
            |> IO.inspect(label: "updated instructions")

          instructions =
            List.replace_at(instructions, 0, new_instruction)
            |> IO.inspect(label: "updated instructions in full")

          setup_move(instructions, chart)

        Enum.count(remaining) == 0 ->
          IO.inspect("remaining = 0")
      end
    else
      IO.inspect(chart, label: "final chart")
    end
  end

  defp read_in_and_split() do
    "lib/input.txt"
    |> File.read!()
    |> String.split("\n")
  end
end
