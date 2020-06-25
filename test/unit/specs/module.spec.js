let webDialog;
let authSession;

const IOS = (Ti.Platform.osname === 'iphone' || Ti.Platform.osname === 'ipad');

describe('ti.webDialog', function () {

	it('can be required', () => {
		webDialog = require('ti.webdialog');

		expect(webDialog).toBeDefined();

		if (IOS) {
			authSession = webDialog.createAuthenticationSession({
				url: 'https://www.axway.com?callbackUrl=testwebdialog://', // Your OAuth-URL + app-scheme as callback-URL
				scheme: 'testwebdialog://', // app-scheme
			});

			expect(authSession).toBeDefined();
		}

	});

	describe('methods', () => {

		describe('.open()', () => {
			it('is a Function', () => {
				expect(webDialog.open).toEqual(jasmine.any(Function));
			});

			if (IOS) {
				it('should load url and fire "open" & "close" event', done => {
					webDialog.addEventListener('close', function (event) {
						done();
					});

					webDialog.addEventListener('open', function (event) {
						webDialog.close({});
						done();
					});

					webDialog.open({ url: 'https://axway.com' });
				});
			}
		});

		describe('.isSupported()', () => {
			it('is a Function', () => {
				expect(webDialog.isSupported).toEqual(jasmine.any(Function));
			});

			it('returns a boolean', () => {
				expect(webDialog.isSupported()).toEqual(jasmine.any(Boolean));
			});
		});

		describe('.close()', () => {
			it('is a Function', () => {
				expect(webDialog.close).toEqual(jasmine.any(Function));
			});
		});

		describe('.isOpen()', () => {
			it('is a Function', () => {
				expect(webDialog.isOpen).toEqual(jasmine.any(Function));
			});

			it('returns a boolean', () => {
				expect(webDialog.isOpen({})).toEqual(jasmine.any(Boolean));
			});
		});

		if (IOS) {

			describe('authSession start()', () => {
				it('is a Function', () => {
					expect(authSession.start).toEqual(jasmine.any(Function));
				});
			});

			describe('authSession cancel()', () => {
				it('is a Function', () => {
					expect(authSession.cancel).toEqual(jasmine.any(Function));
				});
			});

			describe('authSession isSupported()', () => {
				it('is a Function', () => {
					expect(authSession.isSupported).toEqual(jasmine.any(Function));
				});

				it('returns a boolean', () => {
					expect(authSession.isSupported()).toEqual(jasmine.any(Boolean));
				});
			});
		}

	});
});
