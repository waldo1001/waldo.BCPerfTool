codeunit 62286 "CreateCustomer WPT"
{
    Subtype = Test;

    var
        MessageCount: Integer;

    [HandlerFunctions('CustomerTemplate,MessageHandler')]
    [Test]
    procedure CreateCustomer()
    var
        HandleCountWPT: Codeunit "HandleCount WPT";
        CustomerCard: TestPage "Customer Card";
    begin
        MessageCount := 0;

        CustomerCard.OpenNew();
        CustomerCard.Name.SetValue('waldo');
        CustomerCard.Address.SetValue('MyStreet');
        CustomerCard."Address 2".SetValue('1234');
        CustomerCard."Post Code".SetValue('2350');
        CustomerCard.City.SetValue('Vosselaar');
        CustomerCard.Close();

        HandleCountWPT.SetCount(MessageCount);
    end;

    [ModalPageHandler]
    procedure CustomerTemplate(var SelectCustomerTemplList: TestPage "Select Customer Templ. List");
    begin
        SelectCustomerTemplList.OK().Invoke();
    end;

    [MessageHandler]
    procedure MessageHandler(MessageText: Text[1024])
    begin
        if MessageText = 'OnAfterModifyEvent' then
            MessageCount += 1;
    end;
}