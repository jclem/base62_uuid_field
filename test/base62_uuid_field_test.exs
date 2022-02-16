defmodule Base62UUIDFieldTest do
  use ExUnit.Case, async: true

  setup do
    uuid = Ecto.UUID.generate()
    {:ok, ecto_dumped_uuid} = Ecto.UUID.dump(uuid)
    {:ok, uuid: uuid, encoded_uuid: Base62UUID.encode!(uuid), ecto_dumped_uuid: ecto_dumped_uuid}
  end

  test ".autogenerate/0 generates a Base62 UUID" do
    assert String.length(Base62UUIDField.autogenerate()) == 22
  end

  test ".cast/1 casts to a string" do
    assert Base62UUIDField.cast("1") == {:ok, "1"}
  end

  test ".cast/1 on a non-binary returns an error" do
    assert Base62UUIDField.cast(1) == :error
  end

  test ".dump/1 decodes the value to a UUID", %{
    encoded_uuid: encoded_uuid,
    ecto_dumped_uuid: ecto_dumped_uuid
  } do
    assert Base62UUIDField.dump(encoded_uuid) == {:ok, ecto_dumped_uuid}
  end

  test ".dump/1 on a non-binary returns an error" do
    assert Base62UUIDField.dump(1) == :error
  end

  test ".dump/1 returns an error for a non-UUID" do
    assert Base62UUIDField.dump("!") == :error
  end

  test ".load/1 encodes the value to a Base62 UUID", %{
    ecto_dumped_uuid: ecto_dumped_uuid,
    encoded_uuid: encoded_uuid
  } do
    assert Base62UUIDField.load(ecto_dumped_uuid) == {:ok, encoded_uuid}
  end

  test ".load/1 on a non-binary returns an error" do
    assert Base62UUIDField.load(1) == :error
  end

  test ".load/1 returns an error for a non-UUID" do
    assert Base62UUIDField.load("not-a-uuid") == :error
  end

  test ".type/0 is a string" do
    assert Base62UUIDField.type() == :string
  end
end
