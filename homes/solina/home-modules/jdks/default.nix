{
	pkgs,
	lib,
	config,
	...
}: let
	jvmDir = "${config.xdg.dataHome}/jvm";
	jdks = [
		{ vendor = "openjdk"; version = "1.8"; path = "${pkgs.jdk8}/lib/openjdk"; }
		{ vendor = "openjdk"; version = "11"; path = "${pkgs.jdk11}/lib/openjdk"; }
		{ vendor = "openjdk"; version = "17"; path = "${pkgs.jdk17}/lib/openjdk"; }
		{ vendor = "openjdk"; version = "21"; path = "${pkgs.jdk21}/lib/openjdk"; }
		{ vendor = "openjdk"; version = "25"; path = "${pkgs.jdk25}/lib/openjdk"; }
		
		{ vendor = "temurin"; version = "1.8"; path = "${pkgs.temurin-bin-8}"; }
		{ vendor = "temurin"; version = "17"; path = "${pkgs.temurin-bin-17}"; }
		{ vendor = "temurin"; version = "21"; path = "${pkgs.temurin-bin-21}"; }

		{ vendor = "zulu"; version = "8"; path = "${pkgs.zulu8.override { gtkSupport = false; }}"; }
		{ vendor = "zulu"; version = "17"; path = "${pkgs.zulu17}"; }
		{ vendor = "zulu"; version = "21"; path = "${pkgs.zulu21}"; }
	];
	jdkName = jdk: "${lib.strings.toLower jdk.vendor}-${jdk.version}";
	mkJdkToolchain = jdk: ''
	<toolchain>
		<type>jdk</type>
		<provides>
			<version>${jdk.version}</version>
			<vendor>${lib.strings.toLower jdk.vendor}</vendor>
		</provides>
		<configuration>
			<jdkHome>${jvmDir}/${jdkName jdk}</jdkHome>
		</configuration>
	</toolchain>
	'';
in {
	home.packages = with pkgs; [
		maven
		jdk25
	];


	home.file = {
		".jdks".source = config.lib.file.mkOutOfStoreSymlink jvmDir;
		".gradle/jdks".source = config.lib.file.mkOutOfStoreSymlink jvmDir;
		".gradle/gradle.properties".text = ''
org.gradle.java.installations.paths=${jvmDir}";
org.gradle.java.installations.auto-download=false
		'';
		
		".m2/toolchains.xml".text = ''
<?xml version="1.0" encoding="UTF-8"?>
<toolchains>
${lib.strings.concatMapStringsSep "\n" mkJdkToolchain jdks}
</toolchains>
		'';
	};

	xdg.dataFile = builtins.listToAttrs (map (jdk: {
		name = "jvm/${jdkName jdk}${if (builtins.pathExists "${jdk.path}/bin/javac") then "" else "-jre"}";
		value = { source = jdk.path; };
	}) jdks);
}

