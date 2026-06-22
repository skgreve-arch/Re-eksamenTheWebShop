pageextension 50102 "Sales Order Processor Ext" extends "Sales Order Processor"
{
    layout
    {
        addfirst(factboxes)
        {
            part(ProductSalesChart; "Product Sales Chart")
            {
                ApplicationArea = All;
                Caption = 'Webshop Salg';
            }
        }
    }
}