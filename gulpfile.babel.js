'use strict';

import _ from 'lodash';
import File from 'vinyl';
import gulp from 'gulp';
import rename from 'gulp-rename';
import replace from 'gulp-replace';
import through2 from 'through2';

/** Names of directories containing icons. */
const ICON_CATEGORIES = [
  'action',
  'alert',
  'av',
  'communication',
  'content',
  'device',
  'editor',
  'file',
  'hardware',
  'image',
  'maps',
  'navigation',
  'notification',
  'places',
  'social',
  'toggle',
];

/*
 * generate helper.rb from sprite.svg
 */
gulp.task('icon-helpers', () => 
  gulp.src('./assets/svg-sprite/svg-sprite-action.svg')
    .pipe(transformToRubyHelper('icon_helpers.rb'))
    .pipe(gulp.dest('./lib/material_icons_svg')));

/*
 * copy Material Icons to assets/images/svg
 */
gulp.task('copy-icons', () =>
  ICON_CATEGORIES.map((category) => {
    var count = 0;
    gulp.src(`../material-design-icons/${category}/svg/production/*_24px.svg`)
      .pipe(step())
      .pipe(gulp.dest('./app/assets/images/svg'))
      .on('data', () => count++)
      .on('end', () => console.log(`${category}... ${count} icons copied`))
  }));

/*
 * inspect each file for counting
 */
function step() {
  return through2.obj(function(file, encoding, callback) {
    this.push(file);
    callback();
  });
}

/*
 * generate rails helper.rb from svg sprite file
 */
function transformToRubyHelper(path){
  const header = '<?xml version="1.0" encoding="utf-8"?><svg width="360" height="360" viewBox="0 0 360 360" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">';
  const footer = /<\/svg>$/;
  const helperTemplate = _.template('def icon_<%=type%>; \'<svg class="mdicon mdicon-<%=type%>" width="24" height="24" viewBox="0 0 24 24"><%=path%></svg>\'.html_safe;end;')

  return through2.obj((file, encoding, callback) => {
    const content = _(file.contents.toString()).replace(header, '')
      .replace(footer, '');
    
    var icons = _.split(content, '</svg>');
    icons = icons.map((icon) => {
      const parsing = /id="ic_(.+)_24px".+(<path.+\/>)/.exec(icon);
      if (parsing) {
        const type = parsing[1];
        const path = parsing[2];
        return helperTemplate({
          type,
          path
        });
      }
    })
    
    icons.unshift('module MaterialIconsSvg\n\nmodule IconHelpers');
    icons.push('end\n\nend');
    
    callback(null, new File({
      path,
      contents: new Buffer(icons.join('\n\n'), 'utf-8')
    }));
  });
}
