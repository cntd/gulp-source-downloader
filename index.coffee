gulp 		= require 'gulp'
run			= require 'run-sequence'
git 		= require 'gulp-git'
del			= require 'del'
streamqueue = require 'streamqueue'

tmp_dir = './tmp/source'

tag=null
projects=null
path=null



gulp.task 'source:clean', (callback)->
	del ['./tmp/source'], callback

gulp.task 'source:clone', (callback)=>
	git.exec {args : "clone --branch #{@tag} #{@repo_url} #{tmp_dir}", quiet: true}, (err)->
		if (err)
			throw err
		else
			callback()

gulp.task 'source:copy', =>
	Q = new streamqueue({ objectMode: true })
	for project in @projects
		Q.queue gulp.src("#{tmp_dir}/user/projects/#{project}/**/*", {"base" : "#{tmp_dir}/user/projects"}).pipe(gulp.dest(@path))
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
