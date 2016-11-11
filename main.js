/*###
  tileshrink - reduce and simplify vector and mbtiles
  by Michael Strassburger <codepoet@cpan.org>
###*/
require('coffee-script/register');
const Tileshrink = require('./src/Tileshrink');

shrinker = new Tileshrink();
shrinker.shrink(__dirname+"/mbtiles/regensburg.mbtiles");
