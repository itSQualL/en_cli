defmodule EnCli do
  @moduledoc """
  Engima Client API wrapper
  """

  alias EnCli.Engines.Device

  @spec list_devices(owner_id: String.t(), page: integer(), page_size: integer()) ::
          {:ok, %{}} | {:error, %{message: String.t()}}
  defdelegate list_devices(opts \\ []), to: Device, as: :index

  @spec get_device(String.t()) :: {:ok, %{device: %{}}} | {:error, %{message: String.t()}}
  defdelegate get_device(uid), to: Device, as: :show

  @spec link_device(String.t(), String.t()) ::
          {:ok, %{message: String.t()}}
          | {:error, %{errors: %{}}}
          | {:error, %{message: String.t()}}
  defdelegate link_device(uid, owner_id), to: Device, as: :create

  @spec update_device(String.t(), %{}) ::
          {:ok, %{message: String.t()}}
          | {:error, %{message: String.t()}}
  defdelegate update_device(uid, params), to: Device, as: :update

  @spec unlink_device(String.t()) :: {:ok, String.t()} | {:error, %{message: String.t()}}
  defdelegate unlink_device(uid), to: Device, as: :delete

  @spec start_engine(String.t()) :: {:ok, %{message: String.t()}} | {:error, %{message: String.t()}}
  def start_engine(uid), do: update_device(uid, %{running: true})

  @spec stop_engine(String.t()) :: {:ok, %{message: String.t()}} | {:error, %{message: String.t()}}
  def stop_engine(uid), do: update_device(uid, %{running: false})
end
