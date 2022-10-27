codeunit 62287 "CreateCustomerTestRunner WPT"
{
    Subtype = TestRunner;
    TestIsolation = Codeunit;
    SingleInstance = true;

    var
        CodeunitToRun: Integer;

    trigger OnRun()
    begin
        Codeunit.Run(CodeunitToRun);
    end;


    procedure SetCodeunitToRun(Id: Integer)
    begin
        CodeunitToRun := Id;
    end;

}