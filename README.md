# gulp-source-downloader
[![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url]  [![Coverage Status][coveralls-image]][coveralls-url] [![Dependency Status][depstat-image]][depstat-url]

> source-downloader plugin for [gulp](https://github.com/wearefractal/gulp)

## Usage

First, install `gulp-source-downloader` as a development dependency:

```shell
npm install --save-dev gulp-source-downloader
```

Then, add it to your `gulpfile.coffee`:

```coffee
source = require "gulp-source-downloader"

gulp.task 'source', (callback)->
	source
		tag: 'docs.v.0.5.8'
		path: './public/app/main/markup'
		projects: ['docs-cntd', 'kit']
		callback
```

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)
