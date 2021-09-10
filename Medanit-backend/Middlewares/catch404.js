function catch404(app) {
    app.use(function (req, res, next) {
        const err = new Error('Not Found');
        err.status = 404;
        next(err);
    });
};

module.exports = catch404;