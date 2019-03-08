defmodule EnCli do
  @moduledoc """
  Engima Client API wrapper
  """

  alias EnCli.Engines.Device

  @spec list_devices([owner_id: String.t, page: integer(), page_size: integer()]) :: {:ok, %{}} | {:error, %{}}
  defdelegate list_devices(opts \\ []), to: Device, as: :index

  #@spec link_device(String.t, String.t) :: {:ok, String.t} | {:error, %{}}
  #defdelegate link_device(uid, owner_id), to: Device, as: :create

  #@spec update_device(String.t, [name: String.t, pressure_transducers: list(%{})] :: {:ok, %{}} | {:error, %{}}
  #defdelegate update_device(uid, owner_id), to: Device, as: :update

  #@spec unlink_device(String.t) :: {:ok, %{}} | {:error, %{}}
  #defdelegate unlink_device(uid), to: Device, as: :delete
end
