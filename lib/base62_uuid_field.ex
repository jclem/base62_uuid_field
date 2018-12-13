defmodule Base62UUIDField do
  @moduledoc """
  A field that is stored as a v4 UUID but presented as a Base62-encoded binary string.
  """

  @behaviour Ecto.Type

  @spec type() :: :string
  def type, do: :string

  @spec cast(any) :: {:ok, String.t()} | :error
  def cast(val) when is_binary(val), do: {:ok, val}
  def cast(_), do: :error

  @spec dump(any) :: {:ok, any} | :error
  def dump(val) when is_binary(val) do
    with {:ok, decoded} <- Base62UUID.decode(val) do
      Ecto.UUID.dump(decoded)
    else
      _ -> :error
    end
  end

  def dump(_), do: :error

  @spec load(any) :: {:ok, any} | :error
  def load(val) when is_binary(val) do
    with {:ok, loaded} <- Ecto.UUID.load(val),
         {:ok, decoded} <- Base62UUID.encode(loaded) do
      {:ok, decoded}
    else
      _ -> :error
    end
  end

  def load(_), do: :error

  @spec autogenerate() :: String.t()
  def autogenerate, do: Base62UUID.generate()
end
