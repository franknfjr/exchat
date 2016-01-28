defmodule Exchat.ChannelControllerTest do
  use Exchat.ConnCase

  alias Exchat.{Channel, User}
  @valid_attrs %{name: "general"}
  @invalid_attrs %{}

  setup do
    user = Repo.insert(%User{email: "tony@ex.chat", password: "password"})
    conn = conn
    |> put_req_header("accept", "application/json")
    |> assign(:current_user, user)
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, channel_path(conn, :index)
    assert json_response(conn, 200) == []
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, channel_path(conn, :create), channel: @valid_attrs
    assert json_response(conn, 201)["id"]
    assert Repo.get_by(Channel, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, channel_path(conn, :create), channel: @invalid_attrs
    assert json_response(conn, 400)["errors"] != %{}
  end
end
