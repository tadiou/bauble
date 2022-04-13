defmodule Bauble.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bauble.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      valid_attributes(attrs)
      |> Bauble.Accounts.register_user()

    user
  end

  def valid_attributes(attrs \\ %{}) do
    password = attrs[:password] || "#{Faker.Lorem.characters(12)}"
    hashed_password = Bcrypt.hash_pwd_salt(password)
    active = if attrs[:active] != nil, do: attrs[:active], else: false

    attrs
    |> Enum.into(%{
      name: attrs[:name] || Faker.Person.name(),
      email: attrs[:email] || Faker.Internet.email(),
      location: attrs[:location] || Faker.Pokemon.location(),
      active: active,
      mtgo_handle: attrs[:mtgo_handle] || Faker.Pokemon.name(),
      mtga_handle: attrs[:mtga_handle] || "#{Faker.Pokemon.name()}##{:rand.uniform(9999)}",
      password: password,
      hashed_password: hashed_password
    })
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  # Only used for phx_gen_auth
  def unique_user_email, do: "user#{System.unique_integer()}@example.com"

  # Only used for phx_gen_auth
  def valid_user_password, do: "hello world!"
end
