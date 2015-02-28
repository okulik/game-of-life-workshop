defmodule Conway do
  @doc """
  Initializes grid
  """
  def new(grid \\ {}), do: grid

  @doc """
  Get grid size (grid is quadratic).
  """
  def size(grid), do: tuple_size(grid)

  @doc """
  Returns 0 or 1 for grid cell given its x, y coordinates.
  """
  def cell_status(grid, col, row) do
    grid |> elem(row) |> elem(col)
  end

  @doc """
  Inverts grid.
  """
  def invert(grid) do
    for row <- 0..(size(grid) - 1) do
      for col <- 0..(size(grid) - 1) do
        1 - cell_status(grid, col, row)
      end |>
      List.to_tuple
    end |>
    List.to_tuple
  end

  def valid_coordinate?(grid, col, row) do
    col in 0..(size(grid) - 1) and row in 0..(size(grid) - 1)
  end

  def alive_neighbours(grid, col, row) do
    for x_off <- -1..1, y_off <- -1..1,
      x_off != 0 or y_off != 0,
      valid_coordinate?(grid, col + x_off, row + y_off) do
      cell_status(grid, col + x_off, row + y_off)
    end |>
    Enum.sum
  end

  def next_cell_status(grid, col, row) do
    alive_num = alive_neighbours(grid, col, row)
    cell_status = cell_status(grid, col, row)
    cond do
      cell_status == 1 and alive_num < 2 ->
        0
      cell_status == 1 and alive_num > 3 ->
        0
      cell_status == 1 ->
        1
      cell_status == 0 and alive_num == 3 ->
        1
      true ->
        0
    end
  end

  def next(grid) do
    for row <- 0..(size(grid) - 1) do
      for col <- 0..(size(grid) - 1) do
        next_cell_status(grid, col, row)
      end |>
      List.to_tuple
    end |>
    List.to_tuple
  end
end
