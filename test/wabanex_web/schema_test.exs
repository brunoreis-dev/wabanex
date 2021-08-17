defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users querries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "bruno@banana.com", name: "Bruno", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "bruno@banana.com",
            "id" => user_id,
            "name" => "Bruno"
          }
        }
      }

      assert response == expected_response
    end
  end

  describe "user mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Camila",
            email: "camila@banana.com",
            password: "123456"
          }) {
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Camila"}}} = response
    end
  end
end
