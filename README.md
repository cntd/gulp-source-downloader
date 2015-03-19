(PLUGIN AUTHOR: Please read [Plugin README conventions](https://github.com/wearefractal/gulp/wiki/Plugin-README-Conventions), then delete this line)

# gulp-source-downloader
[![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url]  [![Coverage Status][coveralls-image]][coveralls-url] [![Dependency Status][depstat-image]][depstat-url]

> source-downloader plugin for [gulp](https://github.com/wearefractal/gulp)

## Usage

First, install `gulp-source-downloader` as a development dependency:

```shell
npm install --save-dev gulp-source-downloader
```

Then, add it to your `gulpfile.js`:

```javascript
var source-downloader = require("gulp-source-downloader");

gulp.src("./src/*.ext")
	.pipe(source-downloader({
		msg: "Hello Gulp!"
	}))
	.pipe(gulp.dest("./dist"));
```

## API

### source-downloader(options)

#### options.msg
Type: `String`  
Default: `Hello World`

The message you wish to attach to file.


## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)

[npm-url]: https://npmjs.org/package/gulp-source-downloader
[npm-image]: https://badge.fury.io/js/gulp-source-downloader.png

[travis-url]: http://travis-ci.org/Freezko/gulp-source-downloader
[travis-image]: https://secure.travis-ci.org/Freezko/gulp-source-downloader.png?branch=master

[coveralls-url]: https://coveralls.io/r/Freezko/gulp-source-downloader
[coveralls-image]: https://coveralls.io/repos/Freezko/gulp-source-downloader/badge.png

[depstat-url]: https://david-dm.org/Freezko/gulp-source-downloader
[depstat-image]: https://david-dm.org/Freezko/gulp-source-downloader.png
