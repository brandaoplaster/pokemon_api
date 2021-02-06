defmodule PokemonApiWeb.Router do
  use PokemonApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug PokemonApiWeb.Auth.Pipiline
  end

  scope "/api", PokemonApiWeb do
    pipe_through :api

    post "/trainers", TrainersController, :create
    get "/pokemon/:name", PokemonsController, :show
    post "/trainers/signin", TrainersController, :sign_in
  end

  scope "/api", PokemonApiWeb do
    pipe_through [:api, :auth]

    resources "/trainers", TrainersController, only: [:show, :delete, :update]
    resources "/trainer_pokemon", TrainerPokemonsController, only: [:create, :show, :delete, :update]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PokemonApiWeb.Telemetry
    end
  end
end
