codeunit 62353 "Demo - PartRec (Debug) Ext WPT"
{
    #region PartialRecordsWithSortingExtField
    procedure PartialRecordsWithSortingExtField()
    var
        JustSomeExtendedTable4WPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeExtendedTable4WPT.SetCurrentKey("Field51 WPT"); //Field from TableExtension
        JustSomeExtendedTable4WPT.SetLoadFields(Message);       //Which is not loaded
        if JustSomeExtendedTable4WPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeExtendedTable4WPT.Next() = 0;
    end;
    #endregion

    #region PartialRecordsWithSortingLoadedField
    procedure PartialRecordsWithSortingLoadedField()
    var
        JustSomeExtendedTable4WPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeExtendedTable4WPT.SetCurrentKey("Field51 WPT");          //Field from TableExtension
        JustSomeExtendedTable4WPT.SetLoadFields(Message, "Field51 WPT"); //Which is loaded
        if JustSomeExtendedTable4WPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeExtendedTable4WPT.Next() = 0;
    end;
    #endregion
    #region PartialRecordsWithFilteringExtField
    procedure PartialRecordsWithFilteringExtField()
    var
        JustSomeExtendedTable4WPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeExtendedTable4WPT.Setfilter("Field51 WPT", '<>%1', 1); //Field from TableExtension
        JustSomeExtendedTable4WPT.SetLoadFields(Message);              //Which is not loaded
        if JustSomeExtendedTable4WPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeExtendedTable4WPT.Next() = 0;
    end;
    #endregion

    #region PartialRecordsWithFilteringLoadedField
    procedure PartialRecordsWithFilteringLoadedField()
    var
        JustSomeExtendedTable4WPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeExtendedTable4WPT.Setfilter("Field51 WPT", '<>%1', 1);     //Field from TableExtension
        JustSomeExtendedTable4WPT.SetLoadFields(Message, "Field51 WPT");   //Which is loaded
        if JustSomeExtendedTable4WPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeExtendedTable4WPT.Next() = 0;
    end;
    #endregion

    #region PartialRecordsWithRowVersion
    procedure PartialRecordsWithRowVersion()
    var
        JustSomeExtendedTable4WPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
        RowVersion: BigInteger;
    begin
        JustSomeExtendedTable4WPT.SetLoadFields(Message, SystemRowVersion);
        if JustSomeExtendedTable4WPT.FindSet() then;
        repeat
            i += 1;
            RowVersion := JustSomeExtendedTable4WPT.SystemRowVersion;
            if i > 7500 then exit;
        until JustSomeExtendedTable4WPT.Next() = 0;
    end;
    #endregion

    #region PartialRecordsWithJITRowVersion
    procedure PartialRecordsWithJITRowVersion()
    var
        JustSomeExtendedTable4WPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
        RowVersion: BigInteger;
    begin
        JustSomeExtendedTable4WPT.SetLoadFields(Message);
        if JustSomeExtendedTable4WPT.FindSet() then;
        repeat
            i += 1;
            RowVersion := JustSomeExtendedTable4WPT.SystemRowVersion;
            if i > 7500 then exit;
        until JustSomeExtendedTable4WPT.Next() = 0;
    end;
    #endregion

    #region InterfaceImplementation
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - Partial Records (Debug)", 'OnAfterGetProcedures', '', false, false)]
    local procedure OnAfterGetProcedures(var Result: List of [Text[50]]);
    begin
        Result.Add('PartialRecordsWithSortingExtField');
        Result.Add('PartialRecordsWithSortingLoadedField');
        Result.Add('PartialRecordsWithFilteringExtField');
        Result.Add('PartialRecordsWithFilteringLoadedField');
        Result.Add('PartialRecordsWithRowVersion');
        Result.Add('PartialRecordsWithJITRowVersion');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo - Partial Records (Debug)", 'OnAfterRun', '', false, false)]
    local procedure OnAfterRun(ProcedureName: Text);
    begin
        case ProcedureName of
            'PartialRecordsWithSortingExtField':
                PartialRecordsWithSortingExtField();
            'PartialRecordsWithSortingLoadedField':
                PartialRecordsWithSortingLoadedField();
            'PartialRecordsWithFilteringExtField':
                PartialRecordsWithFilteringExtField();
            'PartialRecordsWithFilteringLoadedField':
                PartialRecordsWithFilteringLoadedField();
            'PartialRecordsWithRowVersion':
                PartialRecordsWithRowVersion();
            'PartialRecordsWithJITRowVersion':
                PartialRecordsWithJITRowVersion();
        end;
    end;

    #endregion
}
