module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      glob_to_multiple:
        expand: true
        cwd: 'src'
        src: ['*.coffee']
        dest: 'lib'
        ext: '.js'

    coffeelint:
      options:
        max_line_length:
          level: 'ignore'
      src: ['src/**/*.coffee']
      test: ['spec/**/*.coffee']

    shell:
      rebuild:
        command: 'node-gyp rebuild'
        options:
          stdout: true
          stderr: true
          failOnError: true

      test:
        command: 'jasmine-focused --captureExceptions --coffee spec/'
        options:
          stdout: true
          stderr: true
          failOnError: true

      cleanBuild:
        command: 'rm -fr build'
        options:
          stdout: true
          stderr: true
          failOnError: true

      cleanMake:
        command: 'make clean'
        options:
          stdout: true
          stderr: true
          failOnError: true
          execOptions:
            cwd: 'deps/onig'

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-shell')
  grunt.registerTask('default', ['lint', 'coffee', 'shell:rebuild'])
  grunt.registerTask('test', ['default', 'shell:test'])
  grunt.registerTask('clean', ['shell:cleanBuild', 'shell:cleanMake'])
  grunt.registerTask('lint', ['coffeelint'])
