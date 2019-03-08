defmodule EnCli.Engines.Device do
  @moduledoc """
  API engines/devices endpoint
  """
  alias EnCli.Client

  def index(opts \\ []), do: Client.index("/engines/devices", opts)

  #def create(uid, owner_id) do
    #Client.post("/engines/devices", [], [uid: uid, owner_id: owner_id])
  #end

  #def update(uid, opts) do
    #Client.put("/engines/devices/" <> uid, [], opts)
  #end

  #def delete(uid) do
    #Client.delete("/engines/devices/" <> uid)
  #end
end
