defmodule EnCli.Client do
  @moduledoc """
  HTTPoison Implementation
  """
  use HTTPoison.Base

  @headers [{"Content-type", "application/json"}]

  def index(url, opts \\ []) do
    url
    |> get([], params: Enum.into(opts, %{}))
    |> custom_response
  end

  def create(url, params) do
    url
    |> post(params, @headers)
    |> custom_response
  end

  def update(url, params) do
    url
    |> put(params, @headers)
    |> custom_response
  end

  def delete(url, opts \\ []) do
    url
    |> delete([], params: Enum.into(opts, %{}))
    |> custom_response
  end

  def process_request_url(url), do: Application.get_env(:en_cli, :base_uri) <> url

  def process_request_params(params), do: put_credentials(params)

  def process_request_body(body), do: Poison.encode!(body)

  def process_response(%{status_code: 200, body: body}), do: {:ok, Poison.decode!(body)}
  def process_response(%{status_code: 201, body: body}), do: {:ok, Poison.decode!(body)}

  def process_response(%{status_code: 401, body: body}), do: {:error, Poison.decode!(body)}
  def process_response(%{status_code: 404, body: body}), do: {:error, Poison.decode!(body)}
  def process_response(%{status_code: 422, body: body}), do: {:error, Poison.decode!(body)}

  def process_response(%{status_code: 500}), do: {:error, %{message: "Internal Server Error"}}

  def custom_response({:ok, response}), do: response
  def custom_response({:error, %HTTPoison.Error{reason: :econnrefused}}), do: {:error, "bad connection"}

  defp put_credentials(params) do
    params
    |> Map.put(:username, Application.get_env(:en_cli, :username))
    |> Map.put(:token, Application.get_env(:en_cli, :token))
  end
end
