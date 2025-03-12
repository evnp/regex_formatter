defmodule RegexFormatterTest do
  use ExUnit.Case

  import Assertions
  import RegexFormatter

  describe "RegexFormatter" do
    test "greets the world", do: assert(~u"hello world" === "hello world")
  end
end
