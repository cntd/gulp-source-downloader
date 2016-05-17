gulp 		= require 'gulp'
run			= require 'run-sequence'
git 		= require 'gulp-git'
del			= require 'del'
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

copy= (copy_this)=>
	return gulp.src(copy_this, {"base" : "#{tmp_dir}/user/projects"})
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
	copy_this = []
	for project in @projects
		copy_this.push "#{tmp_dir}/user/projects/#{project}/**/*"
	return copy(copy_this)

module.exports = (options, callback) =>
	{@tag, @projects, @path, @repo_url} = options

	@repo_url ?= 'http://gitlab.dmz/kodeks/source.git'

	if !@tag
		throw 'Не определена версия ( тэг)'
	else if !@projects? && !@path?
		throw 'Не определены проекты или path'
	else
		run 'source:clean', 'source:clone', 'source:copy', 'source:clean', callback
