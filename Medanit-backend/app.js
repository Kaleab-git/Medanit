const debug = require('debug')('app:startup');  // set/export DEBUG=app:startup
const mongoose = require('mongoose');
const express = require('express');
const config = require('config');
const path = require('path');
const morgan = require('morgan');

const startupErrorHandler = require('./Middlewares/startupErrorHandlers');
const catch404 = require('./Middlewares/catch404');

const posts = require('./routes/posts');
const comments = require('./routes/comments');
const users = require('./routes/users');
const auth = require('./routes/auth');

const app = express();
app.use(express.json());


if(!config.get('jwtPrivateKey')){
    console.error('FATAL ERROR: jwtPrivateKey is not set.');
    process.exit(1);
}


// config
//console.log(`App name: ${config.get('name')}`);
//console.log(`App db password: ${config.get('db.password')}`);


if (app.get('env') === 'development') {
    app.use(morgan('tiny'));
    debug('using Morgan');
}

// connect to DB
mongoose.connect(config.get('db.connection_string'), { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => debug('Connected to MongoDB'))
    .catch(err => console.error('Could not connect to MongoDB ', err)); 
// ROUTES
app.use('/api/v1/posts', posts);
app.use('/api/v1/posts/:post_id/comments', comments);
app.use('/api/v1/users', users);
app.use('/api/v1/auth', auth);

// catch 404 and forward to error handler
catch404(app);
// error handler
startupErrorHandler(app);

    

app.set('port', process.env.PORT || 3000);

const server = app.listen(app.get('port'), function () {
    debug('Express server listening on port ' + server.address().port);
});
