module.exports = (grunt) ->
  
  banner = '/*! <%= pkg.name %> - v<%= pkg.version %> - <%= date %> */\n'
  
  grunt.initConfig
    date: grunt.template.today('dd-mm-yyyy')
    pkg: grunt.file.readJSON 'package.json'
    coffee:
      options:
        sourceMap: true
      app:
        files:
          'dist/<%= pkg.name %>.js': ['src/*.coffee']
      test:
        files: [{
          expand: true,
          cwd: 'test/',
          src: ['**/*.coffee'],
          dest: 'test/',
          ext: '.js'
        }]
    uglify:
      options:
        banner: banner
        report: 'gzip'
      dist:
        files:
          'dist/<%= pkg.name %>.min.js': ['dist/<%= pkg.name %>.js']
    coffeelint:
      app: ['src/**/*.coffee'],
      test: ['src/**/*.coffee'],
      grunt: ['Gruntfile.coffee']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'test', ['coffeelint']
  grunt.registerTask 'default', ['coffeelint', 'coffee', 'uglify']
