module.exports = function(grunt) {

    var jsfiles = [
        'Gruntfile.js',
        'index.js',
        'lib/**/*.js',
        'test/**/*.js'
    ];

    grunt.initConfig({
        trimtrailingspaces: {
            main: {
                src: jsfiles
            }
        },
        jsbeautifier: {
            options: {
                config: '.jsbeautifyrc'
            },
            files: jsfiles
        },
        jshint: {
            options: {
                jshintrc: '.jshintrc'
            },
            files: jsfiles
        },
        jscs: {
            options: {
                config: '.jscsrc'
            },
            files: jsfiles
        }
    });

    /*
    grunt.loadNpmTasks('grunt-trimtrailingspaces');
    grunt.loadNpmTasks('grunt-jsbeautifier');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-jscs');
    */
    require('load-grunt-tasks')(grunt);

    grunt.registerTask('sa-format', ['trimtrailingspaces', 'jsbeautifier']);
    grunt.registerTask('sa-lint', ['jshint', 'jscs']);
    grunt.registerTask('sa', ['sa-format', 'sa-lint']);
};
