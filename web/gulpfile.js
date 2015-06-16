var gulp = require('gulp');
var pkg = require('./package.json');
var header = require('gulp-header');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var gutil = require('gulp-util');
var jshint = require('gulp-jshint');
var stylish = require('jshint-stylish');
var uglify = require('gulp-uglify');
var buffer = require('gulp-buffer');
var source = require('vinyl-source-stream');
var sourcemaps = require('gulp-sourcemaps');
var compass = require('gulp-compass');
var minifyCSS = require('gulp-minify-css');
var rename = require('gulp-rename');

gulp.task('default', ['watch'], function(){ 
	console.log("[Gulpfile] Default launched: Watching for changes...");
});

gulp.task('styles', function(){
	return gulp.src('./_scss/**/*.scss')
		.pipe(compass({
			config_file: './config.rb',
			css: './css',
			sass: '_scss/',
			environment: 'production'
		}))
		.pipe(header("/* \n- <%= pkg.name %> \n- <%= pkg.description %> \n- v<%= pkg.version %> \n- <%= pkg.license %> licensed \n- Copyright (C) 2015 <%= pkg.author %> \n*/\n\n", { pkg: pkg }))
	.pipe(gulp.dest('css'))
    	.pipe(rename({ suffix: '.min' }))
    	.pipe(minifyCSS())
    	.pipe(header("/* \n- <%= pkg.name %> \n- <%= pkg.description %> \n- v<%= pkg.version %> \n- <%= pkg.license %> licensed \n- Copyright (C) 2015 <%= pkg.author %> \n*/\n\n", { pkg: pkg }))
	.pipe(gulp.dest('./css'));
});

gulp.task('scripts', ['lint'], function(){
	var bundler = browserify({ 
		entries: ['./_js/app.js'],
		debug: true
	});

	return bundler.bundle()
		.on('error', function(err) { 
			console.log(err.message); 
			gutil.beep(); 
			this.emit('end'); 
		})
		.pipe(source('app.js'))
		.pipe(buffer())
		.pipe(sourcemaps.init({loadMaps: true}))
		/*.pipe(uglify())*/
		.pipe(header("/* \n- <%= pkg.name %> \n- <%= pkg.description %> \n- v<%= pkg.version %> \n- <%= pkg.license %> licensed \n- Copyright (C) 2015 <%= pkg.author %> \n*/\n\n", { pkg: pkg }))
		.pipe(sourcemaps.write('./', { 
			sourceRoot: '../' 
		}))
		.pipe(gulp.dest('./js'))
	;
});

gulp.task('lint', function(){
	return gulp.src('_js/**/*.js')
    	.pipe(jshint())
    	.pipe(jshint.reporter(stylish))
    ;
});

gulp.task('watch', ['scripts', 'styles'], function(){
	var jsWatch = gulp.watch(['_js/**/*.js', '_hbs/**/*.hbs'], ['scripts']);
	var scssWatch = gulp.watch(['_scss/**/*.scss'], ['styles']);

	jsWatch.on('change', function(e){
		console.log('JavaScript File ' + e.path + ' was ' + e.type + ', running tasks...');
	});

	scssWatch.on('change', function(e){
		console.log('Compass File ' + e.path + ' was ' + e.type + ', running tasks...');
	});
});
