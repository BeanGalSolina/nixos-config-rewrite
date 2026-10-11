{
	pkgs,
	...
}: {
	programs.vesktop = {
		enable = true;
		package = pkgs.vesktop.overrideAttrs {
			patches = [
				(pkgs.fetchpatch {
					url = "https://patch-diff.githubusercontent.com/raw/Vencord/Vesktop/pull/1251.patch";
					hash = "sha256-WmnXRISB1vfnbvSXJlD6sGkl5HSBTHpye+ezLyidtHU=";
				})
			];
		};

		vencord = {
			settings = {
				plugins = {
					Experiments.enabled = true;
					AutomodContext.enabled = true;
					BetterRoleContext.enabled = true;
					CopyEmojiMarkdown = {
						enabled = true;
						copyUnicode = true;
					};
					CopyUserURLs.enabled = true;
					Dearrow = {
						enabled = true;
						hideButton = false;
						replaceElements = 0;
					};
					ForceOwnerCrown.enabled = true;
					FriendsSince.enabled = true;
					MessageLoggerEnhanced.enabled = true;
					ImplicitRelationships.enabled = true;
					KeepCurrentChannel.enabled = true;
					MessageLinkEmbeds = {
						enabled = true;
						listMode = "blacklist";
						idList = "";
						automodEmbeds = "never";
					};
					MoreUserTags = {
						enabled = true;
						tagSettings = {
							WEBHOOK = {
								text = "WebHook";
								showInChat = true;
								showInNotChat = true;
							};
							OWNER = {
								text = "Owner";
								showInChat = true;
								showInNotChat = true;
							};
							ADMINISTRATOR = {
								text = "Admin";
								showInChat = true;
								showInNotChat = true;
							};
							MODERATOR_STAFF = {
								text = "Staff";
								showInChat = true;
								showInNotChat = true;
							};
							MODERATOR = {
								text = "Mod";
								showInChat = true;
								showInNotChat = true;
							};
							VOICE_MODERATOR = {
								text = "VC Mod";
								showInChat = true;
								showInNotChat = true;
							};
							CHAT_MODERATOR = {
								text = "Chat Mod";
								showInChat = true;
								showInNotChat = true;
							};
						};
					};
					MutualGroupDMs.enabled = true;
					NoOnboardingDelay.enabled = true;
					NormalizeMessageLinks.enabled = true;
					PictureInPicture.enabled = true;
					PlatformIndicators = {
						enabled = true;
						colorMobileIndicator = true;
						list = true;
						badges = true;
						messages = true;
					};
					RelationshipNotifier.enabled = true;
					Summaries = {
						enabled = true;
						summaryExpiryThresholdDays = 3;
					};
					ShowHiddenThings = {
						enabled = true;
						showTimeouts = true;
						showInvitesPaused = true;
						showModView = true;
						disableDiscoveryFilters = true;
						disableDisallowedDiscoveryFilters = true;
					};
					ShowHiddenChannels.enabled = true;
					SilentTyping = {
						enabled = true;
						showIcon = true;
						contextMenu = true;
						isEnabled = true;
					};
					TypingTweaks = {
						enabled = true;
						alternativeFormatting = true;
						showRoleColors = true;
						showAvatars = true;
					};
					ValidReply.enabled = true;
					ValidUser.enabled = true;
					ViewRaw.enabled = true;
					VoiceDownload.enabled = true;
					NoTrack = {
						enabled = true;
						disableAnalytics = true;
					};
					Settings = {
						enabled = true;
						settingsLocation = "aboveNitro";
					};
					FixSpotifyEmbeds.enabled = true;
					FixYoutubeEmbeds.enabled = true;
					YoutubeAdblock.enabled = true;
					WatchTogetherAdblock.enabled = true;
					NewPluginsManager.enabled = true;
					NoProfileThemes.enabled = true;
					ColorSighted.enabled = true;
					BetterFolders = {
						enabled = true;
						sidebar = true;
						sidebarAnim = true;
						closeAllFolders = true;
						closeAllHomeButton = true;
						closeOthers = true;
						forceOpen = true;
						keepIcons = true;
						showFolderIcon = 1;
					};
					PlainFolderIcon.enabled = true;
					FullUserInChatbox.enabled = true;
					IrcColors.enabled = true;
					MessageClickActions = true;
					FakeNitro.enabled = true;
				};
			};
		};
	};
}

