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
          total_entries: 1,
          devices: [
            %{uid: "asdf"}
          ]
        }} = EnCli.list_devices
      end
    end

    test "with bad credentials" do
      use_cassette "list_devices_with_bad_credentials" do
        assert {:error, %{message: "bad credentials"}} = EnCli.list_devices
      end
    end
  end

  describe "get_device/1" do
    test "with good params" do
      use_cassette "get_device" do
        assert {:ok, %{
          device: %{
            uid: "asdf"
          }
        }} = EnCli.get_device("asdf")
      end
    end

    test "with bad credentials" do
      use_cassette "get_device_with_bad_credentials" do
        assert {:error, %{message: "bad credentials"}} = EnCli.get_device("bad")
      end
    end

    test "with bad uid" do
      use_cassette "get_device_with_bad_params" do
        assert {:error, %{message: "Resource not found"}} = EnCli.link_device("bad_device", "221")
      end
    end
  end

  describe "link_device/2" do
    test "with good params" do
      use_cassette "link_device" do
        assert {:ok, %{message: _}} = EnCli.link_device("asdf", "221")
      end
    end

    test "with bad uid" do
      use_cassette "link_device_with_bad_params" do
        assert {:error, %{message: "Resource not found"}} = EnCli.link_device("bad_device", "221")
      end
    end

    test "with already linked device" do
      use_cassette "link_device_with_already_linked_device" do
        assert {:error, %{errors: _}} = EnCli.link_device("asdf", "220")
      end
    end

    test "with bad credentials" do
      use_cassette "link_device_with_bad_credentials" do
        assert {:error, %{message: "bad credentials"}} = EnCli.link_device("asdf", "221")
      end
    end
  end

  describe "update_device/2" do
    test "with good params" do
      use_cassette "update_device" do
        assert {:ok, %{message: "Device updated"}} = EnCli.update_device("asdf", %{name: "engine1"})
      end
    end

    test "with bad uid" do
      use_cassette "update_device_with_bad_params" do
        assert {:error, %{message: "Resource not found"}} = EnCli.update_device("bad_device", %{name: "engine1"})
      end
    end

    test "with  unlinked device" do
      use_cassette "update_device_with_unlinked_device" do
        assert {:error, %{message: "Resource not found"}} = EnCli.update_device("asdf", %{name: "engine1"})
      end
    end

    test "with bad credentials" do
      use_cassette "update_device_with_bad_credentials" do
        assert {:error, %{message: "bad credentials"}} = EnCli.update_device("asdf", %{name: "engine1"})
      end
    end
  end

  describe "unlink_device/1" do
    test "with good params" do
      use_cassette "unlink_device" do
        assert {:ok, %{message: "Device unlinked"}} = EnCli.unlink_device("asdf")
      end
    end

    test "with bad uid" do
      use_cassette "unlink_device_with_bad_params" do
        assert {:error, %{message: "Resource not found"}} = EnCli.unlink_device("bad_device")
      end
    end

    test "with already unlinked device" do
      use_cassette "unlink_device_with_already_unlinked_device" do
        assert {:error, %{message: "Resource not found"}} = EnCli.unlink_device("asdf")
      end
    end

    test "with bad credentials" do
      use_cassette "unlink_device_with_bad_credentials" do
        assert {:error, %{message: "bad credentials"}} = EnCli.unlink_device("asdf")
      end
    end
  end
end
