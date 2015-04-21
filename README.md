# wombat-oam-cookbook

A Chef cookbook for installing and configuring WombatOAM

## Supported Platforms

* Ubuntu 12.04

## Usage

### wombat-oam::default

Include `wombat-oam` in your node's `run_list` and set the `wombat_oam.url` and `wombat_oam.checksum` attributes:

```json
{
  "run_list": [
    "recipe[wombat-oam::default]"
  ]
}
```

> note: Wombat is not publicly available so you must host your own binary and provide it, and the checksum, as a node attribute.

## Authors

Author:: Jamie Winsor (<jamie@undeadlabs.com>)
