defmodule PokemonApiWeb.TrainerPokemonsController do
  use PokemonApiWeb, :controller
  action_fallback PokemonApi.FallbackController

  def create(conn, params) do
    params
    |> PokemonApi.create_trainer_pokemon()
    |> handle_response(conn, "create.json", :created)
  end

  def get(conn, %{"id" => id}) do
    id
    |> PokemonApi.fetch_trainer_pokemon()
    |> handle_response(conn, "show.json", :ok)
  end

  def update(conn, params) do
    params
    |> PokemonApi.update_trainer_pokemon()
    |> handle_response(conn, "update.json", :ok)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> PokemonApi.delete_trainer_pokemon()
    |> handle_delete(conn)
  end

  def handle_delete({:ok, _pokemon}, conn) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  def handle_delete({:error, _reason}= error, _conn), do: error

  defp handle_response({:ok, pokemon}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, pokemon: pokemon)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
