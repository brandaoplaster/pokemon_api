defmodule PokemonApiWeb.Router do
  use PokemonApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PokemonApiWeb do
    pipe_through :api
    resources "/trainers", TrainersController, only: [:create, :show, :delete, :update]
    resources "/trainer_pokemon", TrainerPokemonsController, only: [:create, :show, :delete, :update]
    get "/pokemon/:name", PokemonsController, :show
    post "/trainers/signin", TrainersController, :sign_in
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PokemonApiWeb.Telemetry
    end
  end
end
