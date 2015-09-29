## HTML scripts

```html
<link rel="stylesheet" href="node_modules/bootstrap/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="node_modules/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="node_modules/angular-ui-select/select.min.css">
<link rel="stylesheet" href="node_modules/animate.css/animate.min.css">

<script src="node_modules/jquery/dist/jquery.min.js"></script>
<script src="node_modules/angular/angular.min.js"></script>
<script src="node_modules/angular-animate/angular-animate.min.js"></script>
<script src="node_modules/angular-ui-router/release/angular-ui-router.min.js"></script>
<script src="node_modules/angular-bootstrap/ui-bootstrap-tpls.min.js"></script>
<script src="node_modules/angular-ui-select/select.min.js"></script>
<script src="node_modules/d3/d3.min.js"></script>
<script src="node_modules/lodash/index.js"></script>
<script src="node_modules/js-base64/base64.min.js"></script>

<script src="node_modules/systemjs/dist/system.js"></script>
<script src="node_modules/requirejs/requirejs.js"></script>
```

## Require.JS

```js
require.config({
    baseUrl: '/base/src',
    paths: {
        'lodash': '../node_modules/lodash/index',
        'jquery': '../node_modules/jquery/dist/jquery.min',
        'angular': '../node_modules/angular/angular.min',
        'angular-mocks': '../node_modules/angular-mocks/angular-mocks',
        'chai': '../node_modules/chai/chai',
        'sinon': '../node_modules/sinon/pkg/sinon'
    },
    shim: {
        'lodash': {exports: '_'},
        'angular': {exports: 'angular', deps: ['jquery']},
        'angular-mocks': {exports: 'angular.mock', deps: ['angular']}
    }
});
```

## Karma

```js
module.exports = function (config) {
    config.set({
        basePath: '',
        frameworks: ['mocha', 'requirejs'],
        files: [
            { pattern : 'node_modules/lodash/index.js', included: false, watched: false },
            { pattern : 'node_modules/jquery/dist/jquery.min.js', included: false, watched: false },
            { pattern : 'node_modules/angular/angular.min.js', included: false, watched: false },
            { pattern : 'node_modules/angular-mocks/angular-mocks.js', included: false, watched: false },
            { pattern : 'node_modules/chai/chai.js', included: false, watched: false },
            { pattern : 'node_modules/sinon/pkg/sinon.js', included: false, watched: false },
            
            { pattern: 'src/**/*.js', included: false },
            { pattern: 'test/**/*.js', included: false },
            'test/test-main.js'
        ],

        exclude: [],

        autoWatch: true,

        // Chrome, PhantomJS
        browsers: ['PhantomJS'],

        preprocessors: {
            'src/**/*.js': 'coverage'
        },

        // possible values: 'dots', 'progress'
        reporters: ['mocha', 'junit', 'coverage'],

        junitReporter: {
            outputFile: 'test-results.xml'
        },

        coverageReporter:{
            // 'html', 'text', 'cobertura'
            type : 'cobertura', 
            dir : 'coverage/'
        },

        port: 9876,

        colors: true,

        // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        logLevel: config.LOG_INFO,

        singleRun: false
    })
};

```
