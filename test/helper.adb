with Ada.Directories; use Ada.Directories;
with Ahven; use Ahven;

package body Helper is
	procedure Assert_Pre_Directory_Create(Directory_Path : String) is
		Exists : Boolean;
	begin
		Exists := Ada.Directories.Exists(Directory_Path);
		if Exists then
			--remove it
			Delete_Directory(Directory_Path);
		end if;
		--Ahven.Assert(not Exists, """" & Directory_Path & """ exists before test");
	end Assert_Pre_Directory_Create;

	procedure Assert_Post_Directory_Create_With_Delete(Directory_Path : String) is
		Exists_And_Kind : Boolean;
	begin
		Exists_And_Kind := Exists(Directory_Path) and then Kind(Directory_Path) = Directory;
		if Exists_And_Kind then
			--remove it
			Delete_Directory(Directory_Path);
		end if;
		Ahven.Assert(Exists_And_Kind, """" & Directory_Path & """ does not exist or is not a directory");
	end Assert_Post_Directory_Create_With_Delete;
end Helper;

