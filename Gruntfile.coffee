module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig(
    # Metadata	
    pkg: grunt.file.readJSON('package.json')
    browserDependencies: grunt.file.readJSON('browserDependencies.json')
    coffee:
      compileJoined:
        options:
          join: true
        files:          
          'build/js/<%= pkg.name %>.js': [
            'src/coffee/**/*.coffee'
            # 'src/coffee/package/*.coffee'
          ] # concat then compile into single file
    copy:
      html: files: [
          expand: true
          cwd: 'src/html/'
          src: ['**/*.html']
          dest: 'build/'
        ]
      lib: files: [
        expand: true
        cwd: 'lib/'
        src: ['**/*.js']
        dest: 'build/lib'
      ]
  )
	
  # Load the plugins
  grunt.loadNpmTasks('grunt-browser-dependencies');
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks('grunt-contrib-copy');

  # Default task(s).
  grunt.registerTask 'default', ['browserDependencies', 'coffee', 'copy']
