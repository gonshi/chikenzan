gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

# Copy All Files At The Root Level (dist)
gulp.task 'copy', (dir) ->
    gulp.src([ config.path.dist + "index.html" ])
        .pipe(gulp.dest("../"))
        .pipe($.size({ title: 'copy' }))

# gulp.task 'copy:docs', () ->
#     gulp.src([])
#         .pipe(gulp.dest())
