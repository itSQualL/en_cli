defmodule EnCliTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes/")
    :ok
  end

  describe "list_devices/1" do
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

    test "with bad credentials" do
      use_cassette "list_devices_with_bad_credentials" do
        assert {:error, %{"message" => "bad credentials"}} = EnCli.list_devices
      end
    end
  end

  describe "link_device/2" do
    test "with good params" do
      use_cassette "link_device" do
        assert {:ok, %{"message" => _}} = EnCli.link_device("asdf", "221")
      end
    end

    test "with bad uid" do
      use_cassette "link_device_with_bad_params" do
        assert {:error, %{"message" => "Resource not found"}} = EnCli.link_device("bad_device", "221")
      end
    end

    test "with already linked device" do
      use_cassette "link_device_with_already_linked_device" do
        assert {:error, %{"errors" => _}} = EnCli.link_device("asdf", "220")
      end
    end

    test "with bad credentials" do
      use_cassette "link_device_with_bad_credentials" do
        assert {:error, %{"message" => "bad credentials"}} = EnCli.link_device("asdf", "221")
      end
    end
  end
end
