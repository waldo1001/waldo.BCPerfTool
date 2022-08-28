table 62105 "PerfTool Setup WPT"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
        }

        field(2; FlameGraphServer; Code[30])
        {
            Caption = 'FlameGraphServer';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Regex: Codeunit Regex;
                IPAddressPatternLbl: label '^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$';
            begin
                if not Regex.IsMatch(FlameGraphServer, IPAddressPatternLbl) then
                    error('Invalid IP Address');
            end;
        }
        field(3; DisableFlamegraph; Boolean)
        {
            Caption = 'Disable Flamegraph';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;


}