defmodule PokemonApiWeb.TrainersController do
  use PokemonApiWeb, :controller
  action_fallback PokemonApi.FallbackController

  def create(conn, params) do
    params
    |> PokemonApi.create_trainer()
    |> handle_response(conn)
  end
  
  def delete(conn, %{"id" => id}) do
    id
    |> Pokemon.delete_trainer()
    |> handle_delete(conn)
  end

  defp handle_delete({:ok, _trainer}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_delete({:error , _changeset} = error, conn), do: error

  defp handle_response({:ok , trainer}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", trainer: trainer)
  end

  defp handle_response({:error , _changeset} = error, conn), do: error
end
