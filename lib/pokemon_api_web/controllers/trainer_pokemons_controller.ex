defmodule PokemonApiWeb.TrainerPokemonsController do
  use PokemonApiWeb, :controller
  action_fallback PokemonApi.FallbackController

  def create(conn, params) do
    params
    |> PokemonApi.create_trainer_pokemon()
    |> handle_response(conn, "create.json", :created)
  end

  defp handle_response({:ok, pokemon}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, pokemon: pokemon)
  end

  defp handle_response({:error, _changeset} = error, _view, _status), do: error
end
