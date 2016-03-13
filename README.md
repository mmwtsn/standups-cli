# standups-cli

## Summary

Manage daily standups from the command line.

## Installation

With [Stack](http://docs.haskellstack.org/en/stable/README/) installed, clone the repository and run:

```bash
$ stack setup # Only if you haven't run this before
$ stack build # Find the path the executable is installed
$ ln -s /usr/local/sbin CLI_PATH # Use executable path from above
```

## Quick start

```bash
$ mkdir ~/.standups # Create the directory where standups will be saved
$ standups --help # See the list of all possible subcommands
$ standups new # Create your first standup
```

## Guide

### Usage

When calling any of the subcommands you will be prompted for a new category and action which will be saved in the appropriate section of the in-progress standup.

### Storage

Standups are saved to your user's `~/.standups` directory in JSON format.

While they are in progress they can be found in the `.in-progress.json` file. Once the standup is complete the in-progress standup is renamed with a time stamp and saved.

The in-progress standup file is reset every time you call `new`.

### Schema

Standups are made up of `done` and `todo` tasks. Each contains a list of tasks which are made up of a `category` and an `action`.

```json
{
  "done": [
    {
      "category": "breakfast",
      "action": "ate a croissant"
    }
  ],
  "todo": [
    {
      "category": "life",
      "action": "write some Haskell"
    }
  ]
}
```

### Presenting

The easiest way to format this data for a text-based standup is to send it through a templating engine like [Mustache](https://mustache.github.io/mustache.1.html). An example template formatted for Slack is included in the `slack.mustache` file.  Ideally this would happen through the CLI but at the moment that functionality is not supported.

## License

MIT
