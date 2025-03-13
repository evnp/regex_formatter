defmodule RegexFormatterTest do
  use ExUnit.Case

  def input() do
    """
    div class: ~u"flex items-center shrink-0 h-16 px-4 shadow" do
      div do
        h2 class: ~u"   text-sm font-semibold leading-none", do: "Thread"
        a class: ~u"text-xs  leading-none   ", href: "#", do: @room.name
      end
      button "phx-click": "close-thread",
        class: ~u"  flex items-center  justify-center
                  w-6 h-6 rounded      hover:bg-gray-300  ml-auto    " do
        c &icon/1, name: " hero-x-mark ", class: ~u"w-5   h-5"
      end
    end
    """
  end

  describe "RegexFormatter" do
    test "All Presets" do
      for ex <- [".ex", ".exs"] do
        assert(
          RegexFormatter.format(input(),
            extension: ex,
            regex_formatter: [
              [
                extensions: [".ex", ".exs"],
                preset_trim_sigil_whitespace: [:u],
                preset_collapse_sigil_whitespace: [:u],
                preset_do_on_separate_line_after_multiline_keyword_args: true
              ]
            ]
          ) ==
            """
            div class: ~u"flex items-center shrink-0 h-16 px-4 shadow" do
              div do
                h2 class: ~u"text-sm font-semibold leading-none", do: "Thread"
                a class: ~u"text-xs leading-none", href: "#", do: @room.name
              end
              button "phx-click": "close-thread",
                class: ~u"flex items-center justify-center
                          w-6 h-6 rounded hover:bg-gray-300 ml-auto"
              do
                c &icon/1, name: " hero-x-mark ", class: ~u"w-5 h-5"
              end
            end
            """
        )
      end
    end

    test "preset_trim_sigil_whitespace" do
      for ex <- [".ex", ".exs"] do
        assert(
          RegexFormatter.format(input(),
            extension: ex,
            regex_formatter: [
              [
                extensions: [".ex", ".exs"],
                preset_trim_sigil_whitespace: [:u]
              ]
            ]
          ) ==
            """
            div class: ~u"flex items-center shrink-0 h-16 px-4 shadow" do
              div do
                h2 class: ~u"text-sm font-semibold leading-none", do: "Thread"
                a class: ~u"text-xs  leading-none", href: "#", do: @room.name
              end
              button "phx-click": "close-thread",
                class: ~u"flex items-center  justify-center
                          w-6 h-6 rounded      hover:bg-gray-300  ml-auto" do
                c &icon/1, name: " hero-x-mark ", class: ~u"w-5   h-5"
              end
            end
            """
        )
      end
    end

    test "preset_collapse_sigil_whitespace" do
      for ex <- [".ex", ".exs"] do
        assert(
          RegexFormatter.format(input(),
            extension: ex,
            regex_formatter: [
              [
                extensions: [".ex", ".exs"],
                preset_collapse_sigil_whitespace: [:u]
              ]
            ]
          ) ==
            """
            div class: ~u"flex items-center shrink-0 h-16 px-4 shadow" do
              div do
                h2 class: ~u"   text-sm font-semibold leading-none", do: "Thread"
                a class: ~u"text-xs leading-none   ", href: "#", do: @room.name
              end
              button "phx-click": "close-thread",
                class: ~u"  flex items-center justify-center
                          w-6 h-6 rounded hover:bg-gray-300 ml-auto    " do
                c &icon/1, name: " hero-x-mark ", class: ~u"w-5 h-5"
              end
            end
            """
        )
      end
    end

    test "preset_trim_sigil_whitespace and preset_collapse_sigil_whitespace" do
      for ex <- [".ex", ".exs"] do
        assert(
          RegexFormatter.format(input(),
            extension: ex,
            regex_formatter: [
              [
                extensions: [".ex", ".exs"],
                preset_trim_sigil_whitespace: [:u],
                preset_collapse_sigil_whitespace: [:u]
              ]
            ]
          ) ==
            """
            div class: ~u"flex items-center shrink-0 h-16 px-4 shadow" do
              div do
                h2 class: ~u"text-sm font-semibold leading-none", do: "Thread"
                a class: ~u"text-xs leading-none", href: "#", do: @room.name
              end
              button "phx-click": "close-thread",
                class: ~u"flex items-center justify-center
                          w-6 h-6 rounded hover:bg-gray-300 ml-auto" do
                c &icon/1, name: " hero-x-mark ", class: ~u"w-5 h-5"
              end
            end
            """
        )
      end
    end

    test "preset_do_on_separate_line_after_multiline_keyword_args" do
      for ex <- [".ex", ".exs"] do
        assert(
          RegexFormatter.format(input(),
            extension: ex,
            regex_formatter: [
              [
                extensions: [".ex", ".exs"],
                preset_do_on_separate_line_after_multiline_keyword_args: true
              ]
            ]
          ) ==
            """
            div class: ~u"flex items-center shrink-0 h-16 px-4 shadow" do
              div do
                h2 class: ~u"   text-sm font-semibold leading-none", do: "Thread"
                a class: ~u"text-xs  leading-none   ", href: "#", do: @room.name
              end
              button "phx-click": "close-thread",
                class: ~u"  flex items-center  justify-center
                          w-6 h-6 rounded      hover:bg-gray-300  ml-auto    "
              do
                c &icon/1, name: " hero-x-mark ", class: ~u"w-5   h-5"
              end
            end
            """
        )
      end
    end
  end
end
