defmodule PokemonApiWeb.Controllers.TrainersControllerTest do
  use PokemonApiWeb.ConnCase
  import PokemonApiWeb.Auth.Guardian
  alias PokemonApi.Trainer

  describe "show/2" do

    setup %{conn: conn} do
      params = %{name: "John Doe", password: "123123"}
      {:ok, trainer} = PokemonApi.create_trainer(params)
      {:ok, token, _claims} = encode_and_sign(trainer)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

    test "when there is a trainer with the given id, returns the trainer", %{conn: conn} do
      params = %{name: "Lucas", password: "123456789"}

      {:ok, %Trainer{id: id}} = PokemonApi.create_trainer(params)

      response =
        conn
        |> get(Routes.trainers_path(conn, :show, id))
        |> json_response(:ok)

      assert %{"id" => _id, "inserted_at" => _inserted_at, "name" => "Lucas"}  = response
    end

    test "when there is an error, returns the error", %{conn: conn} do
      response =
        conn
        |> get(Routes.trainers_path(conn, :show, "1222"))
        |> json_response(:bad_request)

      expect_response = %{"message" => "Invalid ID format!"}
      assert response == expect_response
    end
  end
end
