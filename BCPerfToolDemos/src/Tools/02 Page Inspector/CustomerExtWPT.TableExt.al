tableextension 62202 "Customer Ext WPT" extends Customer
{
    procedure CalcTotalSalesWPT()
    begin
        //Some kind of very slow calculation
        sleep(100)
    end;

}