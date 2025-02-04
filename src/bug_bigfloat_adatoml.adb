with Ada.Text_IO; use Ada.Text_IO;
with Interfaces; use Interfaces;
with TOML; use TOML;

procedure Bug_Bigfloat_Adatoml is
   F : constant IEEE_Float_64 := 1.7976931348623157e+308;
   T : constant TOML_Value :=
         Load_String ("big = 1.7976931348623157e+308").Value;
   B : constant TOML_Value := T.Get ("big");
begin
   if B.Kind /= TOML_Float then
      raise Program_Error with "not a float";
   end if;

   if B.As_Float.Kind /= Regular then
      raise Program_Error with "not a regular float";
   end if;

   if B.As_Float.Value /= Valid_Float (F) then
      raise Program_Error with "not expected value";
   end if;

   Put_Line ("OK");
end Bug_Bigfloat_Adatoml;
