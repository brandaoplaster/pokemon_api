defmodule PokemonApi.PokeApi.ClientTest do
  use ExUnit.Case
  import Tesla.Mock
  
  alias PokemonApi.PokeApi.Client

  @base_url "https://pokeapi.co/api/v2/pokemon/"

  describe "get_pokemon/1" do
    test "should be able to return a pokemon" do
      body = %{
        "name" => "pikachu",
        "weight" => 60,
        "types" => ["electric"]
      }

      mock(fn %{
          method: :get, url: @base_url <> "pikachu"
        } -> %Tesla.Env{status: 200, body: body}
      end)

      response = Client.get_pokemon("pikachu")
      expected_response = {:ok, body}

      assert response == expected_response
    end

    test "should be able to return a not found error" do
      mock(fn %{
        method: :get, url: @base_url <> "invalid"
        } -> %Tesla.Env{status: 404}
      end)

      response = Client.get_pokemon("invalid")
      expected_response = {:error, "Pokemon not found"}

      assert response == expected_response
    end

    test "should be able to return an error by unexpected error" do
      mock(fn %{
          method: :get, url: @base_url <> "pikachu"
        } -> {:error, :timeout}
      end)

      response = Client.get_pokemon("pikachu")
      expected_response = {:error, :timeout}

      assert response == expected_response
    end
  end
end
