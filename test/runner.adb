with Ahven.Framework;
with Ahven.Text_Runner;
with AXDG_Test;

procedure Runner is
   S : Ahven.Framework.Test_Suite := Ahven.Framework.Create_Suite ("All");
begin
   Ahven.Framework.Add_Test (S, new AXDG_Test.Test);
   Ahven.Text_Runner.Run (S);
end Runner;
