package AXDG is
	VAR_XDG_CONFIG  : constant String := "XDG_CONFIG_HOME";
	VAR_XDG_CACHE   : constant String := "XDG_CACHE_HOME";
	VAR_XDG_DATA	: constant String := "XDG_DATA_HOME";
	VAR_XDG_RUNTIME : constant String := "XDG_RUNTIME_DIR";

	function Strip_Double_Slash(Input : String) return String;  --helper function
	function Get_Config (Program_Name : String) return String;  --XDG_CONFIG_HOME or else ${HOME}/.config/<app_name>
	function Get_Cache  (Program_Name : String) return String;  --XDG_CACHE_HOME  or else ${HOME}/.cache/<app_name>
	function Get_Data   (Program_Name : String) return String;  --XDG_DATA_HOME   or else ${HOME}.local/share/<app_name>
	function Get_Runtime(Program_Name : String) return String;  --XDG_RUNTIME_DIR or else XDG_CACHE_HOME
end AXDG;
