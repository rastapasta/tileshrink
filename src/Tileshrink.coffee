###
  tileshrink - reduce and simplify vector and mbtiles
  by Michael Strassburger <codepoet@cpan.org>

  CLI interface
###

Shrinker = require "./Shrinker"
TileGrinder = require "tilegrinder"

commandLineArgs = require "command-line-args"
getUsage = require('command-line-usage')

args = [
    name: "files", type: String, multiple: true, defaultOption: true
  ,
    name: "extent", type: Number, defaultValue: 4096, typeLabel: "[underline]{pixel}"
  ,
    name: "precision", type: Number, defaultValue: 1, typeLabel: "[underline]{sqrt}"
  ,
    name: "maxzoom"
    description: "maximal zoomlevel to import tiles from"
  ,
    name: "mode"
    default: "mbtiles"
]

help = [
    header: "tileshrink", content: "reduce and simplify vector and mbtiles"
  ,
    header: "Options", optionList: args, hide: "files"
]

console.log getUsage help
options = commandLineArgs(args)

shrinker = new Shrinker targetExtent: 4096, precision: 1
grinder = new TileGrinder maxZoom: 5, output: "files"

grinder.grind source, output,
(tile) -> shrinker.shrink tile
