{
	config,
	pkgs,
	...
}: {
	home.packages = [
		pkgs.stgit
	];

	programs.git = {
		enable = true;
		settings = {
			pull.rebase = true;
			safe.directory = "*";

			core = {
				hooksPath = "${config.xdg.configHome}/git/hooks";
				autocrl = "input";
			};

			commit = {
				template = "${./commit-template.txt}";
			};

			init = {
				defaultBranch = "main";
			};
			
			user = {
				name = "BeanGalSolina";
				email = "solina@beangal.dev";
			};

			alias = {
				lg-specific = "log --graph --abbrev-commit --decorate --pretty=\"format:%s <%C(yellow)%h%C(reset)>%n%C(blue)%ci %C(green)(%cr)%n%C()%an <%C(yellow)%ae%C(reset)>%n\"";
				lg = "lg-specific --all";
				graph = "lg";
			};

			submodules = {
				recurse = true;
				fetchJobs = 0;
			};
			diff.submodule = "log";
			status.submoduleSummary = true;
			fetch.recurseSubmodules = "on-demand";
		};
	};

	programs.gh = {
		enable = true;
		gitCredentialHelper.enable = true;
	};

	xdg = {
		enable = true;
		configFile."git/hooks/commit-msg" = {
			source = ./hooks/commit-msg;
			executable = true;
		};
	};
}

