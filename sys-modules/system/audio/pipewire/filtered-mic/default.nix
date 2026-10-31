{
	pkgs,
	...
}: {
	services.pipewire.extraLadspaPackages = [ pkgs.lsp-plugins pkgs.rnnoise-plugin ];
	services.pipewire.extraConfig.pipewire."99-filtered-mic" = {
		"context.modules" = [
			{
				name = "libpipewire-module-filter-chain";
				args = {
					"node.description" = "Filtered Mic";
					"media.name" = "Filtered Mic";
					"filter.graph" = {
						nodes = [
							{
								type = "ladspa";
								name = "rnnoise";
								plugin = "librnnoise_ladspa";
								label = "noise_suppressor_mono";
								control = {
									"VAD Threshold (%)" = 50.0;
									"VAD Grace Period (ms)" = 200;
									"Retroactive VAD Grace (ms)" = 0;
								};
							}
							{
								type = "ladspa";
								name = "gain";
								plugin = "lsp-plugins-ladspa";
								label = "http://lsp-plug.in/plugins/ladspa/filter_mono";
								control = {
									"Gain (G)" = 14.0;
								};
							}
						];

						links = [
							{ output = "rnnoise:Output"; input = "gain:Input"; }
						];

						inputs  = [ "rnnoise:Input" ];
						outputs = [ "gain:Output" ];
					};

					"capture.props" = {
						"node.name"     = "filteredmic.stack_input";
						"node.passive"  = false;
						"audio.rate"    = 48000;
						"audio.position" = [ "MONO" ];
					};

					"playback.props" = {
						"node.name"        = "filteredmic.stack_output";
						"node.description" = "Filtered Mic";
						"media.class"      = "Audio/Source";
						"priority.session" = 2000;
						"audio.rate"       = 48000;
						"audio.position"   = [ "MONO" ];
					};
				};
			}
		];
	};
}

