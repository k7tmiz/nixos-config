{config, pkgs, ...}:

{
	home.username = "bruno";
	home.homeDirectory = "/home/bruno";
	home.stateVersion = "24.11";
	
	programs.fish = {
		enable = true;
		shellAliases = {
			btw = "echo i use nixos btw";
			nrs = "sudo nixos-rebuild switch";
		};
	};
	
	home.packages = with pkgs; [
		bat
	];
}
