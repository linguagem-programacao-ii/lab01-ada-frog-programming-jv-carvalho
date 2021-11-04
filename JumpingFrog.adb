with
    Ada.Strings.Fixed,
    Ada.Text_IO,
    Ada.Integer_Text_IO;
use
    Ada.Strings.Fixed,
    Ada.Text_IO,
    Ada.Integer_Text_IO;

procedure frog is
    -- Variaveis
    String_Buffer : String(1..300) := (others => ' ');
    Sep : String := " ";
    Last_Idx : Natural;
    Split_Idx : Integer;
    Jump_Height : Integer;
    Num_Pipes : Integer;
    Current_Pipe : Integer;
    Current_Jump : Integer;

    procedure Split(Source : in String; Pos: in Integer; Value : out Integer; Remainder: out String) is
        Tmp : String(1..Source'Last);
    begin
        if Pos = Source'Last then Move(Source, Tmp);
        else Move(Source(Source'First .. Pos-1), Tmp); 
            Move(Source(Pos+1 .. Source'Last), Remainder);
        end if;
        Value := Integer'Value(Tmp);
    end Split;
begin
    -- first line
    Get_Line(Item => String_Buffer, Last => Last_Idx);
    Split_Idx := Index(Source => String_Buffer, Pattern => Sep, From => 1);

    Split(Source => String_Buffer, Pos => Split_Idx, Value => Jump_Height, Remainder => String_Buffer);
    Split(Source => String_Buffer, Pos => String_Buffer'Last, Value => Num_Pipes, Remainder => String_Buffer);

    -- second line
    Get_Line(Item => String_Buffer, Last => Last_Idx);
    
    for I in 1 .. Num_Pipes loop
        Split_Idx := Index(Source => String_Buffer, Pattern => Sep, From => 1);
        Split(Source => String_Buffer, Pos => Split_Idx, Value => Current_Jump, Remainder => String_Buffer);
        if I /= 1 and abs(Current_Jump - Current_Pipe) > Jump_Height then
            Put_Line("GAME OVER");
            exit;
        end if;
        Current_Pipe := Current_Jump;
        if I = Num_Pipes then
            Put_Line("YOU WIN");
        end if;
    end loop;
end frog;