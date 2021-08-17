defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, return a valid changeset" do
      params = %{name: "Bruno", email: "bruno@banana.com", password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{name: "Bruno", email: "bruno@banana.com", password: "123456"},
               errors: []
             } = response
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "B", email: "bruno@banana.com"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
