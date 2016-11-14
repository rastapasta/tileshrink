# tileshrink
[![npm version](https://badge.fury.io/js/tileshrink.svg)](https://badge.fury.io/js/tileshrink)
![dependencies](https://david-dm.org/rastapasta/tileshrink.svg)
![license](https://img.shields.io/github/license/rastapasta/tileshrink.svg)

Reduce and simplify all features of all or any [vector tiles](https://github.com/mapbox/vector-tile-spec/tree/master/2.1) in an [MBTiles](https://www.mapbox.com/help/an-open-platform/#mbtiles) container.

Helpful in case

* your maximal projection size is much smaller than the tiles' one

* you want to create a ultra-low-bandwidth MBTiles version

## Requirements

* The upstream library [`tilegrinder`](https://github.com/rastapasta/tilegrinder) uses the native protobuf wrapper library [`node-protobuf`](https://github.com/fuwaneko/node-protobuf) for its magic

* To let it build during `npm install`, take care of following things:

  * Linux: `libprotobuf` must be present (`apt-get install build-essential pkg-config libprotobuf-dev`)

  * OSX: Use [`homebrew`](http://brew.sh/) to install `protobuf` with `brew install pkg-config protobuf`

  * Windows: `node-protobuf` includes a pre-compiled version for 64bit systems


## How to install it?

    npm install -g tileshrink

## How to use it?

```
$ tileshrink --help

tileshrink

  Reduce and simplify Vector Tile features in an MBTiles container

Examples

  $ tileshrink --shrink 4 input.mbtiles output.mbtiles            
  $ tileshrink --shrink 4 --output files input.mbtiles /foor/bar/

Options

  --extent pixel      desired extent of the new layers [deault: 1024]          
  --precision float   affects the level of simplification [deault: 1]             
  --shrink zoom       maximal zoomlevel to apply the shrinking                     
  --include zoom      maximal zoomlevel to import untouched layers from [optional]
  --output type       mbtiles (default) or files                                   
  --help              displays this help screen                                    

made with ⠀❤⠀⠀at https://github.com/rastapasta/tileshrink
```

## License
#### The MIT License (MIT)
Copyright (c) 2016 Michael Straßburger

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
