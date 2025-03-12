# Regex Formatter

Don't fear the regex. Malleable `mix format` via powerful code-search/replace.

## Installation

Add `regex_formatter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:regex_formatter, "~> 0.1.0"}
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
    [
      extensions: [".ex", ".exs"],     #  ┌──── [8] Try handy substitution presets.
      replacements: [                  #  │
        RegexFormatter.preset_trim_sigil_whitespace([:u], collapse: true),
        RegexFormatter.preset_do_on_separate_line_after_multiline_signature(),
      ]
    ]
  ]
]
```

## Prior Art

Inspired by the incredibly cool https://github.com/frerich/filter_formatter, which
also helped provide excellent initial guidance for setting up a `mix format` plugin.

## License

MIT

