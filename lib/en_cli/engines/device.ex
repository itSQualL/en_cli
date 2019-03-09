defmodule EnCli.Engines.Device do
  @moduledoc """
  API engines/devices endpoint
  """
  alias EnCli.Client

  def index(opts \\ []) do
    Client.index("/engines/devices", opts)
  end

  def create(uid, owner_id) do
    params = %{device: %{uid: uid, owner_id: owner_id}}
    Client.create("/engines/devices", params)
  end

  def update(uid, params) do
    Client.update("/engines/devices/" <> uid, %{device: params})
  end

  def delete(uid) do
    Client.delete("/engines/devices/" <> uid)
  end
end
