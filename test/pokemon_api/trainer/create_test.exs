defmodule PokemonApi.Trainer.CreateTest do
  use PokemonApi.DataCase

  alias PokemonApi.{Repo, Trainer}
  alias Trainer.Create

  describe "call/1" do
    test "when all params are valid, create a trainer" do
      params = %{name: "Lucas", password: "123456789"}

      count_before = Repo.aggregate(Trainer, :count)
      response = Create.call(params)
      count_after = Repo.aggregate(Trainer, :count)

      assert {:ok, %Trainer{name: "Lucas"}} = response
      assert count_after > count_before
    end

    test "when there are invalid, returns the error" do
      params = %{name: "Lucas"}

      response = Create.call(params)

      assert {:error, changeset} = response
      assert errors_on(changeset) == %{password: ["can't be blank"]}
    end    
  end
end
