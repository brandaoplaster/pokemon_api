defmodule PokemonApiWeb.TrainersView do
  use PokemonApiWeb, :view

  alias PokemonApi.Trainer

  def render("create.json", %{trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      message: "Trainer created",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end
end
