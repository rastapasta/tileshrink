###
  tileshrink - reduce and simplify vector and mbtiles
  by Michael Strassburger <codepoet@cpan.org>

  Downsamples the extent of all layers and simplifies the resulting polylines
###

Promise = require 'bluebird'
simplify = require 'simplify-js'

module.exports = class Shrinker
  config:
    targetExtent: 512
    precision: 0.5
    clampPoints: true

  constructor: (options) ->
    @config[option] = options[option] for option of options

  shrink: (tile) ->
    for layer in tile.layers
      scale = layer.extent / @config.targetExtent
      features = []
      for feature in layer.features
        geometry = @_scaleAndSimplifyGeometry scale, feature.geometry

        if feature.type is "POLYGON"
          continue if geometry[0].length < 3
          geometry = @_reducePolygon geometry

        else if @config.clampPoints and feature.type is "POINT"
          geometry = @_clampPoints geometry

        continue if not geometry.length or not geometry[0].length

        feature.geometry = geometry
        features.push feature

      layer.features = features
      layer.extent = @config.targetExtent

  _scaleAndSimplifyGeometry: (scale, lines) ->
    for line, i in lines
      for point in line
        point.x = Math.floor point.x/scale
        point.y = Math.floor point.y/scale

      if line.length > 1
        lines[i] = simplify line, @config.precision, true

    lines

  _reducePolygon: (rings) ->
    reduced = [rings[0]]
    for ring in rings[1..]
      if ring.length > 2
        reduced.push ring
    reduced

  _clampPoints: (outer) ->
    clamped = []
    for points in outer
      filtered = []
      for point in points
        if 0 <= point.x < @config.targetExtent and
        0 <= point.y < @config.targetExtent
          filtered.push point

      clamped.push filtered if filtered.length
    clamped
