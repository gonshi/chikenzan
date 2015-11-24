gulp = require 'gulp'
config = require '../config'
pngquant  = require 'imagemin-pngquant'
$ = (require 'gulp-load-plugins')()

# Optimize Images
gulp.task 'imagemin', () ->
    return gulp.src([
        config.path.image + '**/*'
    ])
        .pipe($.cache($.imagemin({
            progressive: true,
            interlaced: true
        })))
        .pipe(gulp.dest(config.path.dist + 'img'))
        .pipe($.size({ title: 'imagemin' }))

# Optimize Images
gulp.task 'imagemin:png', () ->
    return gulp.src(config.path.dist + 'img/**/*.png')
        .pipe($.imagemin({use: [pngquant()]}))
        .pipe(gulp.dest(config.path.dist + 'img'))
        .pipe($.size({ title: 'imagemin:png' }))
