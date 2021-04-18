with Ada.Environment_Variables; use Ada.Environment_Variables;

package body AXDG is
	function Strip_Double_Slash(Input : String) return String is
		Slash_Char : constant Character := '/'; --constant for slash character
		Output : String(Input'Range);
		Last_Char : Character;
		OI : Integer := 1; --output index
	begin
		Output(OI) := Input(OI);
		Last_Char := Input(1);
		for I in 2..Input'Length loop
			if Input(I) /= Slash_Char or else Last_Char /= Slash_Char then --not double slashes, append
				OI := OI + 1;
				Output(OI) := Input(I);
			end if;
			Last_Char := Input(I);
		end loop;
		return Output(1..OI);
	end Strip_Double_Slash;

	--XDG_CONFIG_HOME or else ${HOME}/.config/<app_name>
	function Get_Config (Program_Name : String) return String is
	begin
		if Exists(VAR_XDG_CONFIG) and then Value(VAR_XDG_CONFIG) /= "" then --XDG set and not empty string
			--XDG Dir set manually
			return Strip_Double_Slash(Value(VAR_XDG_CONFIG) & "/" & Program_Name);
		elsif Exists("HOME") and then Value("HOME") /= "" then
			return Strip_Double_Slash(Value("HOME") & "/.config/" & Program_Name);
		else
			--raise Not_Enough_Info_Error(""); --TODO
			return "";
		end if;
	end Get_Config;

	--XDG_CACHE_HOME  or else ${HOME}/.cache/<app_name>
	function Get_Cache  (Program_Name : String) return String is
	begin
		if Exists(VAR_XDG_CACHE) and then Value(VAR_XDG_CACHE) /= "" then --XDG set and not empty string
			--XDG Dir set manually
			return Strip_Double_Slash(Value(VAR_XDG_CACHE) & "/" & Program_Name);
		elsif Exists("HOME") and then Value("HOME") /= "" then
			return Strip_Double_Slash(Value("HOME") & "/.cache/" & Program_Name);
		else
			--raise Not_Enough_Info_Error(""); --TODO
			return "";
		end if;
	end Get_Cache;

	--XDG_DATA_HOME   or else ${HOME}/.local/share/<app_name>
	function Get_Data   (Program_Name : String) return String is
	begin
		if Exists(VAR_XDG_DATA) and then Value(VAR_XDG_DATA) /= "" then --XDG set and not empty string
			--XDG Dir set manually
			return Strip_Double_Slash(Value(VAR_XDG_DATA) & "/" & Program_Name);
		elsif Exists("HOME") and then Value("HOME") /= "" then
			return Strip_Double_Slash(Value("HOME") & "/.local/share/" & Program_Name);
		else
			--raise Not_Enough_Info_Error(""); --TODO
			return "";
		end if;
	end Get_Data;

	--XDG_RUNTIME_DIR or else XDG_CACHE_HOME
	function Get_Runtime(Program_Name : String) return String is
	begin
		if Exists(VAR_XDG_RUNTIME) and then Value(VAR_XDG_RUNTIME) /= "" then --XDG set and not empty string
			--XDG Dir set manually
			return Strip_Double_Slash(Value(VAR_XDG_RUNTIME) & "/" & Program_Name);
		end if;
		--Fallback to Get_Cache
		return Get_Cache(Program_Name);
	end Get_Runtime;
end AXDG;
