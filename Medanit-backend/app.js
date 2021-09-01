const debug = require('debug')('app:startup');  // set/export DEBUG=app:startup
const express = require('express');
const config = require('config');
const path = require('path');
const morgan = require('morgan');

const startupErrorHandler = require('./Middlewares/startupErrorHandlers');
const catch404 = require('./Middlewares/catch404');

const posts = require('./routes/posts');
const comments = require('./routes/comments');
const users = require('./routes/users');

const app = express();
app.use(express.json());


// config
//console.log(`App name: ${config.get('name')}`);
//console.log(`App db connection string: ${config.get('db.connection_string')}`);
//console.log(`App db password: ${config.get('db.password')}`);


if (app.get('env') === 'development') {
    app.use(morgan('tiny'));
    debug('using Morgan');
} 

// ROUTES
app.use('/api/posts', posts);
app.use('/api/posts/:post_id/comments', comments);
app.use('/api/users', users);

// catch 404 and forward to error handler
catch404(app);
// error handler
startupErrorHandler(app);

    

app.set('port', process.env.PORT || 3000);

const server = app.listen(app.get('port'), function () {
    debug('Express server listening on port ' + server.address().port);
});
