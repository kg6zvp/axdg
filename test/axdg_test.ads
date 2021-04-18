with Ahven.Framework;
with System.Assertions;
with Ahven;
use Ahven;
with Helper;
with AXDG;

package AXDG_Test is
	type Test is new Ahven.Framework.Test_Case with null record;
	procedure Initialize ( T : in out Test);

private
	--Strip_Double_Slash
	procedure Test_Should_Strip_Double_Slashes;
	procedure Test_Should_Strip_Triple_Slashes;
	procedure Test_Should_Not_Strip_If_Single_Slashes;

	--Get_Config
	procedure Test_Should_Allow_Config_Override;
	procedure Test_Should_Set_Config_From_Home;
	procedure Test_Should_Raise_If_No_Home_And_No_Override;

	--Get_Cache
	procedure Test_Should_Allow_Cache_Override;
	procedure Test_Should_Set_Cache_From_Home;
	procedure Test_Should_Raise_If_No_Home_And_No_Cache_Override;

	--Get_Data
	procedure Test_Should_Allow_Data_Override;
	procedure Test_Should_Set_Data_From_Home;
	procedure Test_Should_Raise_If_No_Home_And_No_Data_Override;

	--Get_Runtime
	procedure Test_Should_Allow_Runtime_Override;
	procedure Test_Should_Set_Runtime_From_Cache_As_Fallback;
	procedure Test_Should_Raise_If_No_Home_And_No_Runtime_Override;
end AXDG_Test;
