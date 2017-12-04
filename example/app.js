var WebDialog = require('ti.webdialog');
var win = Ti.UI.createWindow({
  backgroundColor: '#fff'
});

var btnOpenDialog = Ti.UI.createButton({
  title: 'Open Web Dialog'
});

win.add(btnOpenDialog);

btnOpenDialog.addEventListener('click', function(event) {
  WebDialog.open({
    url: 'http://appcelerator.com',
    title: 'Hello World',
    
    // iOS 10+
    tintColor: 'red',
    barColor: 'green',

    // iOS 11+
    barCollapsingEnabled: false,
    dismissButtonStyle: WebDialog.DISMISS_BUTTON_STYLE_CLOSE
  });
});

WebDialog.addEventListener('open', function(e) {
  console.log('open: ' + JSON.stringify(e));
});

WebDialog.addEventListener('close', function(e) {
  console.log('close: ' + JSON.stringify(e));
});

nav.open();
