
/*
 * GET home page.
 */

exports.index = function(req, res){
    var user;
    if (req.session.auth) {
//      console.log("auth:\n");
//      console.log(req.session.auth);
//      console.log("\n");
      if (req.session.auth.twitter.user)
        user = req.session.auth.twitter.user.screen_name;
    }
    res.render('index', {
      layout: false,
      locals: {
        title: "Login App",
        user: user
      }
    });
};
