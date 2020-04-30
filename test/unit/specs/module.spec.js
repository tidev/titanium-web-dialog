let webDialog;

const IOS = (Ti.Platform.osname === 'iphone' || Ti.Platform.osname === 'ipad');

describe('ti.webDialog', function () {

	it('can be required', () => {
		webDialog = require('ti.webdialog');

		expect(webDialog).toBeDefined();
	});

	describe('methods', () => {

		describe('.open()', () => {
			it('is a Function', () => {
				expect(webDialog.open).toEqual(jasmine.any(Function));
			});
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

			webDialog = require('ti.webdialog');
			var authSession = webDialog.createAuthenticationSession({});

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
