'use strict';

const COVERAGE_PATH = process.env.CIRCLE_TEST_REPORTS || './coverage';

exports = (config) => {

    config.set({

        // base path, that will be used to resolve files and exclude
        'basePath': '../..',

        'frameworks': [ 'mocha', 'expect' ],

        // list of files / patterns to load in the browser
        'files': [
            'vendor/angular/angular.js',
            'app/app-module.js',
            'app/app-routes.js',
            'app/app-controller.js',
            'app/**/*.js',
            'test/unit/*.js'
        ],

        // list of files to exclude
        'exclude': [
        ],

        'preprocessors': {
            // source files, that you wanna generate coverage for
            // do not include tests or libraries
            // (these files will be instrumented by Istanbul)
            'app/**/*.js': ['coverage']
        },

        'coverageReporter': {
            // specify a common output directory
            'dir': COVERAGE_PATH,

            'reporters': [

                // reporters not supporting the `file` property
                { 'type': 'html', 'subdir': 'report-html' },
                { 'type': 'lcov', 'subdir': 'report-lcov' },

                // reporters supporting the `file` property, use `subdir` to directly
                // output them in the `dir` directory
                { 'type': 'lcovonly', 'subdir': '.', 'file': 'report-lcovonly.info' },
                { 'type': 'text'},
                { 'type': 'text-summary'}
            ]
        },

        // use dots reporter, as travis terminal does not support escaping sequences
        // possible values: 'dots', 'progress'
        // CLI --reporters progress
        'reporters': [ 'dots', 'progress', 'coverage', 'junit' ],

        'junitReporter': {
             // results will be saved as $outputDir/$browserName.xml
            // if included, results will be saved as $outputDir/$browserName/$outputFile
            'outputDir'      : `${COVERAGE_PATH}/junit`,
            'outputFile'     : 'results.xml',

            // suite will become the package name attribute in xml testsuite element
            'suite'          : 'angular-seed-project',

            // add browser name to report and classes names
            'useBrowserName' : false
        },

        // web server port
        // CLI --port 9876
        'port': 9876,

        // enable / disable colors in the output (reporters and logs)
        // CLI --colors --no-colors
        'colors': true,

        // level of logging
        // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        // CLI --log-level debug
        'logLevel': config.LOG_INFO,

        // enable / disable watching file and executing tests whenever any file changes
        // CLI --auto-watch --no-auto-watch
        'autoWatch': false,

        // Start these browsers, currently available:
        // - Chrome
        // - ChromeCanary
        // - Firefox
        // - Opera
        // - Safari (only Mac)
        // - PhantomJS
        // - IE (only Windows)
        // CLI --browsers Chrome,Firefox,Safari
        'browsers': [ 'PhantomJS' ],

        // If browser does not capture in given timeout [ms], kill it
        // CLI --capture-timeout 5000
        'captureTimeout': 20000,

        // Auto run tests on start (when browsers are captured) and exit
        // CLI --single-run --no-single-run
        'singleRun': true,

        // report which specs are slower than 500ms
        // CLI --report-slower-than 500
        'reportSlowerThan': 500,

        'plugins': [
            'karma-mocha',
            'karma-expect',
            'karma-phantomjs-launcher',
            'karma-coverage',
            'karma-junit-reporter'
        ]
    });
};

module.exports = exports;