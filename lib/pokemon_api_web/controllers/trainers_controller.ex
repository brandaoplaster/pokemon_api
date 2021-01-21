defmodule PokemonApiWeb.TrainersController do
  use PokemonApiWeb, :controller

  def create(conn, params) do
    params
    |> PokemonApi.create_trainer()
    |> handle_response(conn)
  end

  defp handle_response({:ok , tariner}, conn) do
    conn
    |> put_status(:ok)
    |> render("create.json", trainer: trainer)
  end
end
