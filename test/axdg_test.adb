with Ada.Environment_Variables; use Ada.Environment_Variables;
with Ahven.Framework;
with System.Assertions;
with Ahven; use Ahven;
with Helper;
with AXDG;

package body AXDG_Test is
	procedure Initialize ( T : in out Test) is
	begin
		Set_Name(T, "AXDG_Test");

		--Strip_Double_Slash
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Strip_Double_Slashes'Access, "00 - Test_Should_Strip_Double_Slashes");
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Strip_Triple_Slashes'Access, "01 - Test_Should_Strip_Triple_Slashes");
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Not_Strip_If_Single_Slashes'Access, "02 - Test_Should_Not_Strip_If_Single_Slashes");

		--Get_Config
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Allow_Config_Override'Access, "03 - Test_Should_Allow_Config_Override");
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Set_Config_From_Home'Access, "04 - Test_Should_Set_Config_From_Home");
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Raise_If_No_Home_And_No_Override'Access, "05 - Test_Should_Raise_If_No_Home_And_No_Override");

		--Get_Cache
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Allow_Cache_Override'Access, "06 - Test_Should_Allow_Cache_Override");
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Set_Cache_From_Home'Access, "07 - Test_Should_Set_Cache_From_Home");
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Raise_If_No_Home_And_No_Cache_Override'Access, "08 - Test_Should_Raise_If_No_Home_And_No_Cache_Override");

		--Get_Data
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Allow_Data_Override'Access, "09 - Test_Should_Allow_Data_Override");
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Set_Data_From_Home'Access, "10 - Test_Should_Set_Data_From_Home");
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Raise_If_No_Home_And_No_Data_Override'Access, "11 - Test_Should_Raise_If_No_Home_And_No_Data_Override");

		--Get_Runtime
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Allow_Runtime_Override'Access, "12 - Test_Should_Allow_Runtime_Override");
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Set_Runtime_From_Cache_As_Fallback'Access, "13 - Test_Should_Set_Runtime_From_Cache_As_Fallback");
		Ahven.Framework.Add_Test_Routine(T, Test_Should_Raise_If_No_Home_And_No_Runtime_Override'Access, "14 - Test_Should_Raise_If_No_Home_And_No_Runtime_Override");
	end Initialize;

	--Strip_Double_Slash
	procedure Test_Should_Strip_Double_Slashes is
		Input : constant String := "//home//dir//thing";
		Expected : constant String := "/home/dir/thing";
	begin
		Assert(Expected = AXDG.Strip_Double_Slash(Input), "Expected """ & Expected & """, got """ & AXDG.Strip_Double_Slash(Input) & """");
	end Test_Should_Strip_Double_Slashes;
	
	procedure Test_Should_Strip_Triple_Slashes is
		Input : constant String := "//home/dir///thing";
		Expected : constant String := "/home/dir/thing";
	begin
		Assert(Expected = AXDG.Strip_Double_Slash(Input), "Expected """ & Expected & """, got """ & AXDG.Strip_Double_Slash(Input) & """");
	end Test_Should_Strip_Triple_Slashes;


	procedure Test_Should_Not_Strip_If_Single_Slashes is
		Input : constant String := "/home/dir/thing";
		Expected : constant String := "/home/dir/thing";
	begin
		Assert(Expected = AXDG.Strip_Double_Slash(Input), "Expected """ & Expected & """, got """ & AXDG.Strip_Double_Slash(Input) & """");
	end Test_Should_Not_Strip_If_Single_Slashes;

	--Get_Config
	procedure Test_Should_Allow_Config_Override is
		Expected : constant String := "build/urmom/prog_name";
	begin
		Helper.Assert_Pre_Directory_Create(Expected);
		Set("XDG_CONFIG_HOME", "build/urmom");
		Assert(Expected = AXDG.Get_Config("prog_name"), "Expected """ & Expected & """, got " & AXDG.Get_Config("prog_name"));
		Clear("XDG_CONFIG_HOME");
		Helper.Assert_Post_Directory_Create_With_Delete(Expected);
	end Test_Should_Allow_Config_Override;

	procedure Test_Should_Set_Config_From_Home is
		Expected : constant String := "build/home/.config/prog_name";
		Original_Home : String := Value("HOME");
	begin
		Helper.Assert_Pre_Directory_Create(Expected);
		Set("HOME", "build/home");
		Assert(Expected = AXDG.Get_Config("prog_name"), "Expected """ & Expected & """, got " & AXDG.Get_Config("prog_name"));
		Set("HOME", Original_Home);
		Helper.Assert_Post_Directory_Create_With_Delete(Expected);
	end Test_Should_Set_Config_From_Home;

	procedure Test_Should_Raise_If_No_Home_And_No_Override is
	begin
		Ahven.Skip("Not Implemented yet");
	end Test_Should_Raise_If_No_Home_And_No_Override;

	--Get_Cache
	procedure Test_Should_Allow_Cache_Override is
		Expected : constant String := "build/urmom/prog_name";
	begin
		Helper.Assert_Pre_Directory_Create(Expected);
		Set("XDG_CACHE_HOME", "build/urmom");
		Assert(Expected = AXDG.Get_Cache("prog_name"), "Expected """ & Expected & """, got " & AXDG.Get_Cache("prog_name"));
		Clear("XDG_CACHE_HOME");
		Helper.Assert_Post_Directory_Create_With_Delete(Expected);
	end Test_Should_Allow_Cache_Override;

	procedure Test_Should_Set_Cache_From_Home is
		Expected : constant String := "build/home/.cache/prog_name";
		Original_Home : String := Value("HOME");
	begin
		Helper.Assert_Pre_Directory_Create(Expected);
		Set("HOME", "build/home");
		Assert(Expected = AXDG.Get_Cache("prog_name"), "Expected """ & Expected & """, got " & AXDG.Get_Cache("prog_name"));
		Set("HOME", Original_Home);
		Helper.Assert_Post_Directory_Create_With_Delete(Expected);
	end Test_Should_Set_Cache_From_Home;

	procedure Test_Should_Raise_If_No_Home_And_No_Cache_Override is
	begin
		Ahven.Skip("Not Implemented yet");
	end Test_Should_Raise_If_No_Home_And_No_Cache_Override;

	--Get_Data
	procedure Test_Should_Allow_Data_Override is
		Expected : constant String := "build/urmom/prog_name";
	begin
		Helper.Assert_Pre_Directory_Create(Expected);
		Set("XDG_DATA_HOME", "build/urmom");
		Assert(Expected = AXDG.Get_Data("prog_name"), "Expected """ & Expected & """, got " & AXDG.Get_Data("prog_name"));
		Clear("XDG_DATA_HOME");
		Helper.Assert_Post_Directory_Create_With_Delete(Expected);
	end Test_Should_Allow_Data_Override;

	procedure Test_Should_Set_Data_From_Home is
		Expected : constant String := "build/home/.local/share/prog_name";
		Original_Home : String := Value("HOME");
	begin
		Helper.Assert_Pre_Directory_Create(Expected);
		Set("HOME", "build/home/");
		Assert(Expected = AXDG.Get_Data("prog_name"), "Expected """ & Expected & """, got " & AXDG.Get_Data("prog_name"));
		Set("HOME", Original_Home);
		Helper.Assert_Post_Directory_Create_With_Delete(Expected);
	end Test_Should_Set_Data_From_Home;

	procedure Test_Should_Raise_If_No_Home_And_No_Data_Override is
	begin
		Ahven.Skip("Not Implemented yet");
	end Test_Should_Raise_If_No_Home_And_No_Data_Override;

	--Get_Runtime
	procedure Test_Should_Allow_Runtime_Override is
		Expected : constant String := "build/urmom/prog_name";
	begin
		Helper.Assert_Pre_Directory_Create(Expected);
		Set("XDG_RUNTIME_DIR", "build/urmom");
		Assert(Expected = AXDG.Get_Runtime("prog_name"), "Expected """ & Expected & """, got " & AXDG.Get_Runtime("prog_name"));
		Clear("XDG_RUNTIME_DIR");
		Helper.Assert_Post_Directory_Create_With_Delete(Expected);
	end Test_Should_Allow_Runtime_Override;

	procedure Test_Should_Set_Runtime_From_Cache_As_Fallback is
		Expected : constant String := "build/home/.cache/prog_name";
		Original_Home : String := Value("HOME");
	begin
		Helper.Assert_Pre_Directory_Create(Expected);
		Set("HOME", "build/home/");
		Assert(Expected = AXDG.Get_Runtime("prog_name"), "Expected """ & Expected & """, got " & AXDG.Get_Runtime("prog_name"));
		Set("HOME", Original_Home);
		Helper.Assert_Post_Directory_Create_With_Delete(Expected);
	end Test_Should_Set_Runtime_From_Cache_As_Fallback;

	procedure Test_Should_Raise_If_No_Home_And_No_Runtime_Override is
	begin
		Ahven.Skip("Not Implemented yet");
	end Test_Should_Raise_If_No_Home_And_No_Runtime_Override;
end AXDG_Test;
