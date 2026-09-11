{
	pkgs,
		config,
		userParams,
		...
}: {
	imports = [
		"${userParams.solina.home-modules}/modern-coreutils"
		"${userParams.solina.home-modules}/utils"
		"${userParams.solina.home-modules}/useless-commands"
	];

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		dotDir = "${config.xdg.configHome}/zsh";

		shellAliases = {
			l = "ls -al";
			ll = "ls -l";
			ls = "eza --color=auto";
			grep = "grep --color=auto";
			rm = "mvtotrash";
			espeak="espeak -a 200 -g 0 -k 16 -p 46";
			espeak-ng="espeak-ng -a 200 -g 0 -k 16 -p 46";
			murder="pkill -9";
			yt-dlp="yt-dlp --download-archive ./yt-dlp-archive -o \"%(playlist_index)s - %(title)s [%(id)s].%(ext)s\" --merge-output-format mkv --write-description --embed-chapters --sub-lang en --embed-subs --embed-metadata --embed-info-json";
			shonk="blahaj -s";
		};

		autosuggestion = {
			enable = true;
			highlight = "fg=cyan,bg=black,underline";
		};

		history = {
			extended = true;
			ignoreDups = true;
			ignoreSpace = true;
			append = true;
			path = "$HOME/.zsh_history";
			save = 10000;
			share = true;
			size = 10000;
		};

		initContent = ''
			if [[ $- =~ i ]] && [[ -n "$SSH_TTY" ]] && [[ -z "$TMUX" ]] # If we are in an interactove shell instance, we are in an ssh session, and we are not already in tmux
			then
				exec tmux new -A
			fi

			autoload -Uz vcs_info
			precmd() { vcs_info }

			EDITOR="${config.programs.neovim.finalPackage}/bin/nvim"
			VISUAL="${config.programs.neovim.finalPackage}/bin/nvim"
			PAGER="${pkgs.w3m}/bin/w3m"

			${builtins.readFile(./envvars.sh)}
			${builtins.readFile(./funcs.sh)}
			${builtins.readFile(./prompt.sh)}

			${builtins.readFile(./welcome.sh)}
		'';

		syntaxHighlighting = {
			enable = true;
		};
	};
}

