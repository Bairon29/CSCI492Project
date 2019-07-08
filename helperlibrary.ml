let printme ss oc = 
begin Printf.fprintf oc "%s" ss; end

let whichFileContent = function
  | "" -> ""
  | "www" -> "#!/usr/bin/env node\n" ^
          "/**\n* Module dependencies.\n*/\n" ^
          "var app = require('../app');\n" ^
          "var debug = require('debug')('react-backend:server');\n" ^
          "var http = require('http');\n\n" ^
          "/**\n* Get port from environment and store in Express.\n*/\n" ^
          "var port = normalizePort(process.env.PORT || '3000');\n" ^
          "app.set('port', port);\n\n" ^
          "/**\n* Create HTTP server.\n*/\n" ^
          "var server = http.createServer(app);\n\n" ^
          "/**\n* Listen on provided port, on all network interfaces.\n*/\n" ^
          "server.listen(port);\n" ^
          "server.on('error', onError);\n" ^
          "server.on('listening', onListening);\n\n" ^
          "/**\n* Normalize a port into a number, string, or false.\n*/\n" ^
          "function normalizePort(val) {\n" ^
          "\tvar port = parseInt(val, 10);\n" ^ 
          "\tif (isNaN(port)) {\n" ^ 
          "\t\treturn val;\n" ^ "\t}\n" ^
          "\tif (port >= 0) {\n" ^ 
          "\t\treturn port;\n" ^ "\t}\n" ^
          "\treturn false;\n}\n\n" ^
          "/**\n* Event listener for HTTP server 'error' event.\n*/\n" ^
          "function onError(error) {\n" ^
          "\tif (error.syscall !== 'listen') {\n" ^
          "\t\tthrow error;\n" ^ "\t}\n" ^
          "\tvar bind = typeof port === 'string'\n" ^
          "\t\t? 'Pipe ' + port\n" ^ "\t\t: 'Port ' + port;\n" ^
          "\t// handle specific listen errors with friendly messages\n" ^
          "\tswitch (error.code) {\n" ^
          "\t\tcase 'EACCES':\n" ^
          "\t\t\tconsole.error(bind + ' requires elevated privileges');\n" ^
          "\t\t\tprocess.exit(1);\n\t\t\tbreak;\n" ^
          "\t\tcase 'EADDRINUSE':\n" ^ 
          "\t\t\tconsole.error(bind + ' is already in use');\n" ^
          "\t\t\tprocess.exit(1);\n\t\t\tbreak;" ^
          "\t\tdefault:\n\t\t\tthrow error;\n" ^
          "\t}\n}\n\n" ^
          "function onListening() {\n" ^
          "\tvar addr = server.address();\n" ^
          "\tvar bind = typeof addr === 'string'\n" ^
          "\t\t? 'pipe ' + addr\n" ^
          "\t\t: 'port ' + addr.port;\n" ^
          "\tdebug('Listening on ' + bind);\n}\n" 
  | "mainScript" -> "console.log('Loaded');"
  | "mainStylesheet" -> "html,\nbody {\n" ^
                        "\twidth: 100%;\n" ^
                        "\theight: 100%;\n" ^
                        "}\n"
  | "routes_index" -> "var express = require('express');\n" ^
                "var router = express.Router();\n\n" ^
                "/* GET home page. */\n" ^
                "router.get('/', function(req, res, next) {\n" ^
                "\tres.render('index', { title: 'Bairon`s Tempplate App' });\n" ^
                "});\n\n" ^
                "module.exports = router;\n"
  | "routes_users" -> "var express = require('express');\n" ^
                "var router = express.Router();\n\n" ^
                "router.get('/', function(req, res, next) {\n" ^
                "\tres.send('respond with a resource');\n" ^
                "});\n\n" ^
                "module.exports = router;\n"
  | "views_error" -> "extends layout\n\n" ^
                  "block content\n" ^
                  "\th1= message\n" ^
                  "\th2= error.status\n" ^
                  "\tpre #{error.stack}\n"
  | "views_index" -> "extends layout\n" ^
                  "block content\n" ^
                  "\th1= title\n" ^
                  "\tp Welcome to #{title}\n"
  | "views_layout" -> "html\n" ^
                  "\thead\n" ^ 
                  "\t\ttitle= title\n" ^
                  "\t\tlink(rel='stylesheet', href='/stylesheets/mainStylesheet.css')\n" ^
                  "\tbody\n" ^
                  "\t\tblock content\n"
  | "app" -> "var createError = require('http-errors');\n" ^
          "var express = require('express');\n" ^
          "var path = require('path');\n" ^
          "var cookieParser = require('cookie-parser');\n" ^
          "var logger = require('morgan');\n\n" ^
          "var indexRouter = require('./routes/index');\n" ^
          "var usersRouter = require('./routes/users');\n\n" ^
          "var app = express();\n\n" ^
          "app.set('views', path.join(__dirname, 'views'));\n" ^
          "app.set('view engine', 'jade');\n\n" ^
          "app.use(logger('dev'));\n" ^
          "app.use(express.json());\n" ^
          "app.use(express.urlencoded({ extended: false }));\n" ^
          "app.use(cookieParser());\n" ^
          "app.use(express.static(path.join(__dirname, 'public')));\n\n" ^
          "app.use('/', indexRouter);\n" ^
          "app.use('/users', usersRouter);\n\n" ^
          "app.use(function(req, res, next) {\n" ^
          "\tnext(createError(404));\n});\n\n" ^
          "app.use(function(err, req, res, next) {\n" ^
          "\tres.locals.message = err.message;\n" ^
          "\tres.locals.error = req.app.get('env') === 'development' ? err : {};\n\n" ^
          "\tres.status(err.status || 500);\n" ^
          "\tres.render('error');\n});\n\n" ^
          "module.exports = app;\n"