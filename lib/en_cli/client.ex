defmodule EnCli.Client do
  @moduledoc """
  HTTPoison Implementation
  """

  use HTTPoison.Base

  def index(url, opts) do
    url
    |> get([], params: Enum.into(opts, %{}))
    |> custom_response
  end

  def process_request_url(url), do: Application.get_env(:en_cli, :base_uri) <> url

  def process_request_params(params) do
    params
    |> Map.put(:username, Application.get_env(:en_cli, :username))
    |> Map.put(:token, Application.get_env(:en_cli, :token))
  end

  def process_response(%{status_code: 200, body: body}), do: {:ok, Poison.decode!(body)}
  def process_response(%{status_code: 201, body: body}), do: {:ok, body}
  def process_response(%{status_code: 401, body: body}), do: {:error, body}
  def process_response(%{status_code: 422, body: body}), do: {:error, body}

  def custom_response({:ok, response}), do: response
  def custom_response({:error, %HTTPoison.Error{reason: :econnrefused}}), do: {:error, "bad connection"}
end
