
'use strict';

const
    APP_PREFIX      = 'angular-seed-project',
    SRC_CODE        = [
        './app/app-module.js',
        './app/**/*.js'
    ],

    BUNDLE_CODE      = SRC_CODE.concat('./build/templatecache/app.templates.js'),
    FOLDERS_TO_CLEAN = [ 'coverage', 'build', 'dist', 'release' ],
    ASSETS_ARRAY     = [ 'assets/**/img/**/*', 'assets/**/icons/*', 'assets/**/js/*/*', 'assets/**/css/*/*' ],
    DIST_PATH        = './dist/',

    gulp          = require('gulp'),
    fs            = require('fs'),
    del           = require('del'),
    flatten       = require('gulp-flatten'),
    eslint        = require('gulp-eslint'),
    karma         = require('karma').server,
    concat        = require('gulp-concat'),
    sourcemaps    = require('gulp-sourcemaps'),
    connect       = require('gulp-connect'),
    minifyHTML    = require('gulp-minify-html'),
    minifyCss     = require('gulp-clean-css'),
    checkCSS      = require('gulp-check-unused-css' ),
    uncss         = require('gulp-uncss'),
    templateCache = require('gulp-angular-templatecache'),
    gutil         = require('gulp-util'),
    ngAnnotate    = require('gulp-ng-annotate'),
    uglify        = require('gulp-uglify'),

    eslint_conf   = require('./.eslintrc'),
    karma_conf    = `${__dirname}/test/conf/karma-conf.js`;

// TASK CHAIN DEFINITIONS
gulp.task('default', [ 'build' ]);
gulp.task('test',    [ 'test:unit', 'eslint' ]);
gulp.task('dev',     [ 'build', 'connect', 'watch', 'icons' ]);
gulp.task('build',   [ 'copy:assets', 'minify:css', 'build:bundle' ]);

// CLEAN FOLDERS
gulp.task('clean', () => del([ FOLDERS_TO_CLEAN ]) );

/* ESLint - rules: http://eslint.org/docs/rules */
gulp.task('eslint', () => { gulp.src(SRC_CODE).pipe(eslint(eslint_conf)).pipe(eslint.format()).pipe(eslint.failAfterError()); });

// Bundling Angular App
gulp.task('build:bundle', [ 'build:min' ],  function () {
    return gulp
        .src(BUNDLE_CODE)
        .pipe(concat(`${APP_PREFIX}.js`))
        .pipe(gulp.dest(gutil.env.src || DIST_PATH));
});

gulp.task('build:min', [ 'minify:html' ], function () {
    return gulp
        .src(BUNDLE_CODE)
        .pipe(sourcemaps.init())
          .pipe(concat(`${APP_PREFIX}.js`))
          .pipe(ngAnnotate())
          .pipe(uglify())
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest(gutil.env.src || DIST_PATH));
});

// UNIT TESTS
gulp.task('test:unit', (cb) => {
    return karma.start({
        'singleRun'  : true,
        'configFile' : karma_conf
    }, cb);
});

gulp.task('copy:assets', function () {
    return gulp.src(ASSETS_ARRAY)
            .pipe(gulp.dest(gutil.env.src
                ? gutil.env.src + '/assets/'
                : './dist/assets'));
});

// MINIFY CSS
gulp.task('minify:css', function () {
    return gulp.src('./src/**/*.css')
            .pipe(sourcemaps.init())
                .pipe(concat(APP_PREFIX + '.min.css'))
                .pipe(minifyCss({ 'processImport': false }))
            .pipe(sourcemaps.write('.'))
            .pipe(gulp.dest(gutil.env.src ? gutil.env.src + '/assets/css' : './dist/assets/css'));
});

// check unused CSS
gulp.task('unused:css', () => {
    return gulp
        .src([ './src/**/*.css', './src/**/*.html' ])
        .pipe( checkCSS() );
});

// remove unused CSS
gulp.task('rm-unused:css', () => {
    return gulp
        .src('./src/**/*.css')
        .pipe(concat(APP_PREFIX + '.min.css'))
        .pipe(uncss({ 'html': [ 'index.html', './src/**/*.html' ] }))
        .pipe(gulp.dest(gutil.env.src ? gutil.env.src + '/assets/css' : './dist/assets/css'));
});

// MINIFY HTML
gulp.task('minify:html', () => {

    return gulp
        .src('./src/**/*.html')
        .pipe(minifyHTML({ 'conditionals': true, 'spare': true }))
        .pipe(flatten())
        .pipe(templateCache('app.templates.js', { 'module': 'plingUi.templates', 'standalone': true }))
        .pipe(gulp.dest('./build/templatecache/'));
});

// GULP CONNECT
gulp.task('connect', ['build'], function () {
    connect.server({ 'livereload': true });
});

// WATCH FILES
gulp.task('watch', function () {
    gulp.watch(['./demo/' + gutil.env.demo +'/**' ], [ 'reload' ]);
    gulp.watch(['./src/components/**' ], [ 'reload' ]);
});

// RELOAD
gulp.task('reload', ['build'], function () {
    connect.reload();
});
