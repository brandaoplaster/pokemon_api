defmodule PokemonApiWeb.TrainerPokemonsView do
  use PokemonApiWeb, :view

  alias PokemonApi.Trainer.Pokemon

  def render("create.json", %{
    pokemon: %Pokemon{
        id: id,
        name: name,
        inserted_at: inserted_at,
        nickname: nickname,
        types: types,
        trainer_id: trainer_id,
        weight: weight
      }
    }) do
    %{
      message: "Pokemon created",
      pokemon: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        nickname: nickname,
        types: types,
        trainer_id: trainer_id,
        weight: weight
      }
    }
  end
end
