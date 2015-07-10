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
          'build/<%= pkg.name %>.js': [
            'src/coffee/**/*.coffee'
            # 'src/coffee/package/*.coffee'
          ] # concat then compile into single file
  )
	
  # Load the plugin that provides the "uglify" and other tasks.
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks('grunt-browser-dependencies');

  # Default task(s).
  grunt.registerTask 'default', ['browserDependencies', 'coffee']
