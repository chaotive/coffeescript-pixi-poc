module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig(
    # Metadata	
    pkg: grunt.file.readJSON('package.json')
    browserDependencies: grunt.file.readJSON('project/browserDependencies.json')
    coffee:
      compileJoined:
        options:
          bare: true
          join: true
        files:          
          'build/js/<%= pkg.name %>.js': [
            'src/coffee/**/*.coffee'
            # 'src/coffee/package/*.coffee'
          ] # concat then compile into single file
    json:
      props:
        options:
          namespace: 'props'
          processName: (filename) -> filename
        src: ['src/*.json']
        dest: 'build/props.js'
    copy:
      statics: files:
          'build/index.html' : ['src/index.html']
      html: files: [
          expand: true
          cwd: 'src/'
          src: ['html/**/*.html']
          dest: 'build/'
        ]
      resources: files: [
          expand: true
          cwd: 'src/'
          src: ['resources/**']
          dest: 'build/'
        ]
      lib: files: [
        expand: true
        src: ['lib/**/*.js']
        dest: 'build/'
      ]
  )
	
  # Load the plugins
  grunt.loadNpmTasks('grunt-browser-dependencies');
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-json');

  # Default task(s).
  grunt.registerTask 'default', ['browserDependencies', 'coffee', 'json', 'copy']
