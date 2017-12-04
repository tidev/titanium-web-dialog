var WebDialog = require('ti.webdialog');

var authSession = WebDialog.createAuthenticationSession({
  url: 'http://0.0.0.0:5000/get-cookie/user?callbackUrl=testwebdialog://', // Your OAuth-URL + app-scheme as callback-URL
  scheme: 'testwebdialog://', // app-scheme
});

// Invoked when the server returns a callback-URL
authSession.addEventListener('callback', function(e) {
  if (!e.success) {
    Ti.API.error('Error authenticating: ' + e.error);
    return;
  }

  Ti.API.info('Callback URL: ' + e.callbackURL);

});

var win = Ti.UI.createWindow({
  backgroundColor: '#fff'
});

var btn = Ti.UI.createButton({
  title: 'Start OAuth-session'
});

btn.addEventListener('click', function() {
  if (!authSession.isSupported()) {
    return Ti.API.error('This API is iOS 11+ only');
  }
  authSession.start(); // Or cancel() to cancel it manually.
});

win.add(btn);
win.open();
