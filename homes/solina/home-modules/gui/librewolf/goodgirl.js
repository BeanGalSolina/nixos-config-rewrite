// first line must be comment
Services.obs.addObserver({
	observe(subject, topic) {
		if (topic != "chrome-document-global-created") return;
		if (!subject.location.href.startsWith("about:preferences")) return;

		const observer = new subject.MutationObserver(() => {
			let promo = subject.document.querySelector("moz-promo#isDefaultPane");

			if (promo && promo.message) {
				let message = promo.message;
				promo.removeAttribute("data-l10n-id");
				promo.message = message.replace("Good choice", "Good girl");
				observer.disconnect();
			}
		});

		observer.observe(subject.document, {
			childList: true,
			subtree: true
		});
	}
}, "chrome-document-global-created");

