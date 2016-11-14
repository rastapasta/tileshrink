###
  tileshrink - reduce and simplify vector and mbtiles
  by Michael Strassburger <codepoet@cpan.org>

  CLI interface for tileshrink
###

Shrinker = require "./Shrinker"
TileGrinder = require "tilegrinder"

commandLineArgs = require "command-line-args"
getUsage = require "command-line-usage"

args = [
    name: "files"
    type: String
    multiple: true
    defaultOption: true
  ,
    name: "extent",
    type: Number,
    defaultValue: 1024,
    typeLabel: "[underline]{pixel}"
    description: "desired extent of the new layers [deault: 1024]"
  ,
    name: "precision",
    type: Number,
    defaultValue: 1,
    typeLabel: "[underline]{float}"
    description: "affects the level of simplification [deault: 1]"
  ,
    name: "shrink"
    type: Number
    description: "maximal zoomlevel to apply the shrinking"
    typeLabel: "[underline]{zoom}"
  ,
    name: "include"
    type: Number
    description: "maximal zoomlevel to import untouched layers from [optional]"
    typeLabel: "[underline]{zoom}"
  ,
    name: "output"
    defaultValue: "mbtiles"
    type: String
    typeLabel: "[underline]{type}"
    description: "[underline]{mbtiles} ([bold]{default}) or [underline]{files}"
  ,
    name: "help"
    description: "displays this help screen"
]

help = [
    header: "tileshrink",
    content: "Reduce and simplify Vector Tile features in an MBTiles container"
  ,
    header: "Examples",
    content: [
      "$ tileshrink [bold]{--shrink} 4 [underline]{input.mbtiles} [underline]{output.mbtiles}"
      "$ tileshrink [bold]{--shrink} 4 [bold]{--output} files [underline]{input.mbtiles} [underline]{/foor/bar/}"
    ]
  ,
    header: "Options"
    optionList: args
    hide: "files"
  ,
    content: [
      "[italic]{made with ⠀❤⠀⠀at https://github.com/rastapasta/tileshrink}"
    ]
    raw: true
]

try
  options = commandLineArgs args
catch e
  console.log getUsage help
  console.log "ERROR: #{e}" if e
  process.exit 1

if e or
options.help or
not options.files or
options.files.length isnt 2 or
typeof options.extent isnt "number" or
typeof options.precision isnt "number" or
typeof options.shrink isnt "number" or
options.output not in ["mbtiles", "files"]
  console.log getUsage help
  process.exit 0

shrinker = new Shrinker
  extent: options.extent
  precision: options.precision
  shrink: options.shrink
  include: options.include

grinder = new TileGrinder
  maxZoom: if options.include then options.include else options.shrink
  output: options.output


console.log getUsage [
  header: "tileshrink"
  content: [
    "[bold]{reducing} zoom levels [bold]{0 to #{options.shrink}} to [bold]{#{options.extent}x#{options.extent}}"
    "[bold]{simplifying} lines with an precision of #{options.precision}"
    if options.include then "[bold]{including} untouched layers of zoom levels [bold]{#{options.shrink+1} to #{options.include}}" else ""
  ]
]

grinder.grind options.files[0], options.files[1],
(tile, z, x, y) -> shrinker.shrink tile, z, x, y
