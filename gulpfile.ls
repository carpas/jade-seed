require! {
	gulp
	\gulp-stylus : stylus
	\gulp-livereload : livereload
	\gulp-autoprefixer : autoprefixer
	\gulp-notify : notify
	\gulp-jade : jade
	\gulp-plumber : plumber
	\./config : {distDir, sourceDir}
}


notifyOnError = ->
	notify!.write it.message


gulp
	..task \compile-jade, !->
		gulp
			.src sourceDir + \/**/*.jade
			.pipe plumber do
				errorHandler: notifyOnError
			.pipe jade!
			.pipe gulp.dest distDir
			.pipe livereload!


	..task \compile-stylus, !->
		gulp
			.src sourceDir + \/**/*.styl
			.pipe plumber do
				errorHandler: notifyOnError
			.pipe stylus!
			.pipe autoprefixer {
				browsers: ["last 2 versions"]
				-cascade
			}
			.pipe gulp.dest "#distDir/css"
			.pipe livereload!


	..task \default, !->
		livereload.listen!
		gulp
			..watch sourceDir + \/**/*.jade, <[compile-jade]>
			..watch sourceDir + \/**/*.styl, <[compile-stylus]>
