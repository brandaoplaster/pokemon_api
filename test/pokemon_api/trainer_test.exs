defmodule PokemonApi.TrainerTest do
  use PokemonApi.DataCase

  alias PokemonApi.Trainer

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Lucas", password: "123456789"}

      response = 
        params  
        |> Trainer.changeset()

      assert %Ecto.Changeset{
        changes: %{
          name: "Lucas",
          password: "123456789",
        },
        errors: [],
        data: %PokemonApi.Trainer{},
        valid?: true
      } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{password: "123456789"}

      response = 
        params  
        |> Trainer.changeset()

      assert %Ecto.Changeset{
        changes: %{
          password: "123456789",
        },
        data: %PokemonApi.Trainer{},
        valid?: false
      } = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a trainer struct" do
      params = %{name: "Lucas", password: "123456789"}

      response = 
        params  
        |> Trainer.build()

      assert {:ok, %Trainer{name: "Lucas", password: "123456789"}} = response
    end

    test "when all params are invalid, returns a error" do
      params = %{password: "123456789"}

      {:error, response} = 
        params  
        |> Trainer.build()

      assert %Ecto.Changeset{ valid?: false } = response
      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end
end
