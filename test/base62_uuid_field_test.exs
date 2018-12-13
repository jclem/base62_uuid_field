defmodule Base62UUIDFieldTest do
  use ExUnit.Case, async: true

  setup do
    uuid = Ecto.UUID.generate()
    {:ok, ecto_dumped_uuid} = Ecto.UUID.dump(uuid)
    {:ok, uuid: uuid, encoded_uuid: Base62UUID.encode!(uuid), ecto_dumped_uuid: ecto_dumped_uuid}
  end

  test ".autogenerate generates a Base62 UUID" do
    assert String.length(Base62UUIDField.autogenerate()) == 22
  end

  test ".type is a string" do
    assert Base62UUIDField.type() == :string
  end

  test ".cast casts to a string" do
    assert Base62UUIDField.cast("1") == {:ok, "1"}
  end

  test ".cast on a non-binary returns an error" do
    assert Base62UUIDField.cast(1) == :error
  end

  test ".dump decodes the value to a UUID", %{
    encoded_uuid: encoded_uuid,
    ecto_dumped_uuid: ecto_dumped_uuid
  } do
    assert Base62UUIDField.dump(encoded_uuid) == {:ok, ecto_dumped_uuid}
  end

  test ".dump on a non-binary returns an error" do
    assert Base62UUIDField.dump(1) == :error
  end

  test ".dump returns an error for a non-UUID" do
    assert Base62UUIDField.dump("!") == :error
  end

  test ".load encodes the value to a Base62 UUID", %{
    ecto_dumped_uuid: ecto_dumped_uuid,
    encoded_uuid: encoded_uuid
  } do
    assert Base62UUIDField.load(ecto_dumped_uuid) == {:ok, encoded_uuid}
  end

  test ".load on a non-binary returns an error" do
    assert Base62UUIDField.load(1) == :error
  end

  test ".load returns an error for a non-UUID" do
    assert Base62UUIDField.load("not-a-uuid") == :error
  end
end
