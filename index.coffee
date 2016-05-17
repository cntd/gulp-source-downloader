gulp 		= require 'gulp'
run			= require 'run-sequence'
git 		= require 'gulp-git'
del			= require 'del'
streamqueue = require 'streamqueue'
plumber		= require 'gulp-plumber'

tmp_dir = './tmp/source'

tag=null
projects=null
path=null



gulp.task 'source:clean', (callback)->
	del ['./tmp/source','./tmp'], callback

gulp.task 'source:clone', (callback)=>
	git.exec {args : "clone --branch #{@tag} #{@repo_url} #{tmp_dir}", quiet: true}, (err)->
		if (err)
			throw err
		else
			callback()

copy= (project)=>
	return gulp.src("#{tmp_dir}/user/projects/#{project}/**/*", {"base" : "#{tmp_dir}/user/projects"})
	.pipe plumber (error)->
		notify.onError({
			title: "Gulp"
			subtitle: "Failure!"
			message: "Error: <%= error.toString() %>"
			sound: "Beep"
			onLast: true
		})(error)
		@.emit('end');
	.pipe(gulp.dest(@path))

gulp.task 'source:copy', =>
	Q = new streamqueue({ objectMode: true })
	for project in @projects
		Q.queue copy
	return Q.done()

module.exports = (options, callback) =>
	{@tag, @projects, @path, @repo_url} = options

	@repo_url ?= 'http://gitlab.dmz/kodeks/source.git'

	if !@tag
		throw 'Не определена версия ( тэг)'
	else if !@projects? && !@path?
		throw 'Не определены проекты или path'
	else
		run 'source:clone', 'source:copy', 'source:clean', callback
