{
	pkgs,
	lib,
	config,
	...
}: let
	jvmDir = "${config.xdg.dataHome}/jvm";
	jdks = [
		{ vendor = "openjdk"; version = "1.8"; path = "${pkgs.jdk8}/lib/openjdk"; }
		{ vendor = "openjdk"; version = "11";  path = "${pkgs.jdk11}/lib/openjdk"; }
		{ vendor = "openjdk"; version = "17";  path = "${pkgs.jdk17}/lib/openjdk"; }
		{ vendor = "openjdk"; version = "21";  path = "${pkgs.jdk21}/lib/openjdk"; }
		{ vendor = "openjdk"; version = "25";  path = "${pkgs.jdk25}/lib/openjdk"; }
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
		".gradle/gradle.properties".text = "org.gradle.java.installations.paths=${jvmDir}";
		
		".m2/toolchains.xml".text = ''
<?xml version="1.0" encoding="UTF-8"?>
<toolchains>
${lib.strings.concatMapStringsSep "\n" mkJdkToolchain jdks}
</toolchains>
		'';
	};

	xdg.dataFile = builtins.listToAttrs (map (jdk: {
		name = "jvm/${jdkName jdk}";
		value = { source = jdk.path; };
	}) jdks);
}

