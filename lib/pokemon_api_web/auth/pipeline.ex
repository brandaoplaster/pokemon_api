defmodule PokemonApiWeb.Auth.Pipiline do
  use Guardian.Plug.Pipeline, otp_app: :pokemon_api

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
