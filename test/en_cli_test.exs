defmodule EnCliTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes/")
    :ok
  end

  describe "list_devices/2" do
    test "with good params" do
      use_cassette "list_devices" do
        assert {:ok, %{
          "total_entries" => 1,
          "devices" => [
            %{"uid" => "asdf"}
          ]
        }} = EnCli.list_devices
      end
    end
  end
end
