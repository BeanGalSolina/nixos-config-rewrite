{
	pkgs,
	NixOSUtils,
	...
}: let
	mkWiki = {name, url, icon, aliases}: {
		name = name;
		urls = [
			{
				template = url;
				params = [
					{
						name = "search";
						value = "{searchTerms}";
					}
					{
						name = "title";
						value = "Special:Search";
					}
				];
			}
		];

		icon = icon;
		definedAliases = aliases;
	};
in {
	programs.librewolf = {
		nativeMessagingHosts = [
			pkgs.keepassxc
		];

		profiles.default = {
			id = 0;
			isDefault = true;

			settings = {
				"privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
				"layout.css.prefers-color-scheme.content-override" = 0;
				"privacy.fingerprintingProtection" = true;
				"privacy.clearOnShutdown.cookies" = false;
				"privacy.clearOnShutdown.history" = false;
				"browser.aboutConfig.showWarning" = false;
				"xpinstall.signatures.required" = false;
				"privacy.resistFingerprinting" = false;
				"extensions.autoDisableScopes" = 0;
				"browser.nova.enabled" = false;
			};

			search.force = true;
			search.default = "google-search";
			search.engines = {
				google.metaData.hidden = true;
				mojeek.metaData.hidden = true;
				amazondotcom-us.metaData.hidden = true;
				bing.metaData.hidden = true;
				ddg.metaData.hidden = true;
				perplexity.metaData.hidden = true;
				wikipedia.metaData.hidden = true;
				ebay.metaData.hidden = true;

				google-search = {
					name = "Google Search";
					urls = [
						{
							template = "https://www.google.com/search";
							params = [
								{
									name = "q";
									value = "{searchTerms}";
								}
							];
						}
					];

					icon = "https://www.google.com/favicon.ico";
					updateInterval = 7 * 24 * 60 * 60 * 1000;
					definedAliases = [ "@gs" ];
				};

				google-images = {
					name = "Google Images";
					urls = [
						{
							template = "https://www.google.com/search";
							params = [
								{
									name = "q";
									value = "{searchTerms} -ai";
								}
								{
									name = "udm";
									value = "2";
								}
							];
						}
					];

					icon = "https://www.google.com/favicon.ico";
					updateInterval = 7 * 24 * 60 * 60 * 1000;
					definedAliases = [ "@gi" ];
				};

				youtube = {
					name = "YouTube";
					urls = [
						{
							template = "https://google.com/search";
							params = [
								{
									name = "q";
									value = "site:youtube.com {searchTerms}";
								}
							];
						}
					];

					icon = "https://www.youtube.com/favicon.ico";
					updateInterval = 7 * 24 * 60 * 60 * 1000;
					definedAliases = [ "@yt" ];
				};

				nix-packages = {
					name = "Nix Packages";
					urls = [
						{
							template = "https://search.nixos.org/packages";
							params = [
								{
									name = "query";
									value = "{searchTerms}";
								}
								{
									name = "channel";
									value = "unstable";
								}
							];
						}
					];

					icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
					definedAliases = [ "@np" ];
				};

				nixos-options = {
					name = "NixOS Options";
					urls = [
						{
							template = "https://search.nixos.org/options";
							params = [
								{
									name = "query";
									value = "{searchTerms}";
								}
								{
									name = "channel";
									value = "unstable";
								}
							];
						}
					];

					icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
					definedAliases = [ "@no" ];
				};

				nixos-wiki = mkWiki {
					name = "NixOS Wiki";
					url = "https://wiki.nixos.org/w/index.php";
					icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
					aliases = [ "@nw" ];
				};

				complex-wikipedia = mkWiki {
					name = "Wikipedia";
					url = "https://en.wikipedia.org/w/index.php";
					icon = "https://en.wikipedia.org/favicon.ico";
					aliases = [ "@wk" ];
				};

				simple-wikipedia = mkWiki {
					name = "Simple Wikipedia";
					url = "https://simple.wikipedia.org/w/index.php";
					icon = "https://simple.wikipedia.org/favicon.ico";
					aliases = [ "@sw" ];
				};
				
				minecraft-wiki = mkWiki {
					name = "Minecraft Wiki";
					url = "https://minecraft.wiki/";
					icon = "https://minecraft.wiki/favicon.ico";
					aliases = [ "@mc" ];
				};

				reddit = {
					name = "Reddit";
					urls = [
						{
							template = "https://reddit.com/search/";
							params = [
								{
									name = "q";
									value = "{searchTerms}";
								}
							];
						}
					];

					icon = "https://www.reddit.com/favicon.ico";
					updateInterval = 7 * 24 * 60 * 60 * 1000;
					definedAliases = [ "@rd" ];
				};
			};

			extensions = {
				packages = with NixOSUtils; [
					(buildFirefoxAddon {
						name = "keepassxc";
						version = "1.10.4.1";
						url = "https://github.com/keepassxreboot/keepassxc-browser/releases/download/1.10.4.1/keepassxc-browser_1.10.4.1_firefox.zip";
						hash = "sha256-FN0zT2ewALElGbvKSveU5QFDHEI1qv6cRxRJGQJVaUw=";
						fixedExtid = "keepassxc-browser@keepassxc.org";
					})
					(buildFirefoxAddon {
						name = "ublock";
						version = "1.76.4";
						url = "https://github.com/gorhill/uBlock/releases/download/1.76.4/uBlock0_1.76.4.firefox.signed.xpi";
						hash = "sha256-ZtDj8hzjsysbwKk5m5PLLJqlmO8YgF2SEYx29m4mbB4=";
					})
					(buildFirefoxAddon {
						name = "indiewikibuddy";
						version = "4.6.1";
						url = "https://github.com/IndieWikiBuddy/indie-wiki-buddy/releases/download/v4.0.1/indie-wiki-buddy-v4.0.1-firefox.zip";
						hash = "sha256-zyXZ93TMxLLH1GcE77LZbRbf1Z0t0wm7/r/qUq5n/ZE=";
					})
					(buildFirefoxAddon {
						name = "ruffle";
						version = "2026.11.17";
						url = "https://github.com/ruffle-rs/ruffle/releases/download/nightly-2026-11-17/ruffle-nightly-2026_11_17-web-extension-firefox-unsigned.xpi";
						hash = "sha256-EpN3RzIZXEOFMgpWSSqfuw5b5riuYaMPM/lrit2D2Zg=";
					})
					(buildFirefoxAddon {
						name = "sponsorblock";
						version = "6.1.7";
						url = "https://github.com/ajayyy/SponsorBlock/releases/download/6.1.7/FirefoxSignedInstaller.xpi";
						hash = "sha256-pQeLr7O2SWpHkNufLu61gVoD99JslRg29eJNn10bk60=";
					})
				];
			};
		};
	};
}


