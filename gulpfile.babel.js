'use strict';

import _ from 'lodash';
import File from 'vinyl';
import gulp from 'gulp';
import rename from 'gulp-rename';
import replace from 'gulp-replace';
import through2 from 'through2';

const header = '<?xml version="1.0" encoding="utf-8"?><svg width="360" height="360" viewBox="0 0 360 360" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">';
const footer = /<\/svg>$/;

gulp.task('icon-helpers', () => 
  gulp.src('./assets/svg-sprite/svg-sprite-action.svg')
    .pipe(transformToRubyHelper('helpers.rb'))
    //.pipe(rename('helpers.rb'))
    .pipe(gulp.dest('.')));

function transformToRubyHelper(path){
  return through2.obj((file, encoding, callback) => {
    const content = _(file.contents.toString()).replace(header, '')
      .replace(footer, '')
      .replace(/<\/svg>/g, '</svg>\n\n');
    
    callback(null, new File({
      path,
      contents: new Buffer(content, 'utf-8')
    }));
  });
}