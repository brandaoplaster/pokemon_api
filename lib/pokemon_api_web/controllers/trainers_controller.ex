defmodule PokemonApiWeb.TrainersController do
  use PokemonApiWeb, :controller
  action_fallback PokemonApi.FallbackController

  def create(conn, params) do
    params
    |> PokemonApi.create_trainer()
    |> handle_response(conn)
  end

  defp handle_response({:ok , trainer}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", trainer: trainer)
  end

  defp handle_response({:error , _changeset} = error, conn), do: error
end
