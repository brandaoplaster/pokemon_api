defmodule PokemonApi.Trainer.Get do
  alias PokemonApi.{Repo, Trainer}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error ->
        {:error, "Invalid ID format!"}

        {:ok, uuid} ->
          delete(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Trainer, uuid) do
      nil ->
        {:error, "Trainer not found!"}
      trainer ->
        {:ok, trainer}
    end
  end
end
