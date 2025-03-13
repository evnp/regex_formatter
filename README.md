# Regex Formatter

Don't fear the regex. Malleable `mix format` via powerful code-search/replace.

## Installation

Add `regex_formatter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:regex_formatter, "~> 0.1"}
  ]
end
```
then
```
mix deps.get
```

## Usage

Configure and run Regex Formatter in three steps:

1. Add `RegexFormatter` to `plugins` list in `.formatter.exs`.
2. Add `regex_formatter` config to `.formatter.exs` following examples below.
3. Run `mix format` — Regex Formatter rules will run after normal format operations.

```elixir
[                                        #  ┌── [1] Add RegexFormatter to plugins.
  ...                                    #  │
  plugins: [Phoenix.LiveView.HTMLFormatter, RegexFormatter],
  regex_formatter: [  #  <───────────────────── [2] Add configuration for RegexFormatter.
    [
      extensions: [".ex", ".exs"],  #  <─────── [3] Configure file types to replace on.
      replacements: [
        {
          ~r/~u["]\s+/s,  #  <───────────────── [4] Define search pattern.
          "~u\""          #  <───────────────── [5] Define replacement pattern.
        },
        {
          ~r/(~u["][^"]+[^"\s])  +([^"\s])/s,
          ~S'\1 \2',   #  <──────────────────── [6] Replace with matched groups.
          repeat: 100,
          # Repeat substitutions to correctly handle overlapping matches.
          # (repeated substitution will stop as soon as text stops changing)
        },
      ]
    ],
    [
      sigils: [:sql],  #  <──────────────────── [7] Try substitution within sigils.
      replacements: [
        {
          ~r/(~u["][^"]+[^"\s])\s+"/s,
          ~S'\1"'
        },
      ]
    ],
    [                               #  ┌─────── [8] Try handy substitution presets.
      extensions: [".ex", ".exs"],  #  │
      preset_trim_sigil_whitespace: [:u],
      preset_collapse_sigil_whitespace: [:u, :SQL],
      preset_do_on_separate_line_after_multiline_keyword_args: true
    ]
  ]
]
```

## Presets

Included preset substitutions can give an idea of what this plugin may be useful for:

- `preset_trim_sigil_whitespace`
    - When provided a list of sigils, eg. `[:u, :SQL]`, this preset will trim leading
      and trailing whitespace from around these sigil values in code. For instance,
      `~u" hello  world  "` will become `~u"hello  world"`. This also works with
      multiline sigil values (without disrupting newlines).
    - Add `preset_trim_sigil_whitespace: [:u, :SQL]` to `regex_formatter` config to
      invoke this preset (see full example above).

- `preset_collapse_sigil_whitespace`
    - When provided a list of sigils, eg. `[:u, :SQL]`, this preset will "collapse"
      extraneous whitespace within these sigil values in code. For instance,
      `~u" hello  world  "` will become `~u" hello world  "`. This also works with
      multiline sigil values (without disrupting newlines).
    - Add `preset_collapse_sigil_whitespace: [:u, :SQL]` to `regex_formatter` config to
      invoke this preset (see full example above).

- `preset_do_on_separate_line_after_multiline_keyword_args`
    - By default, when a function call has keyword args split across multiple lines,
      `mix format` places `do` on the same line as the last keyword arg. Depending on
      exact indentation, this can lead to some difficult-to-read code, as it's not
      always clear at a glance (based on indentation) which lines constitute keyword
      args vs. expressions within the `do` scope.
    - This readability problem is especially pronounced when using the excellent
      [Temple](https://github.com/mhanberg/temple) system to compose HTML templates.
    - This preset solves the problem by moving `do` onto its own line in these cases,
      maintaining correct indentation of keyword args and `do` in the process.
    - Add `preset_do_on_separate_line_after_multiline_keyword_args: true` to
      `regex_formatter` config to invoke this preset (see full example above).

Together, `preset_trim_sigil_whitespace` and `preset_collapse_sigil_whitespace` work
well with the `~u`&nbsp;[unique-words sigil](https://hexdocs.pm/unique_words_sigil),
well-suited for HTML classes where surrounding/repeated spaces are irrelevant<br>
(and class names should be unique).

## Prior Art

Inspired by the incredibly cool https://github.com/frerich/filter_formatter, which
also helped provide excellent initial guidance for setting up a `mix format` plugin.

## License

MIT

