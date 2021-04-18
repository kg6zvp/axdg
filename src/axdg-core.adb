with AXDG;

package body AXDG.Core is
	function Get_Config return String is
	begin
		return AXDG.Get_Config(Program_Name);
	end Get_Config;
	function Get_Cache return String is
	begin
		return AXDG.Get_Cache(Program_Name);
	end Get_Cache;
	function Get_Data return String is
	begin
		return AXDG.Get_Data(Program_Name);
	end Get_Data;
	function Get_Runtime return String is
	begin
		return AXDG.Get_Runtime(Program_Name);
	end Get_Runtime;
end AXDG.Core;
