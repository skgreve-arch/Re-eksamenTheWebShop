pageextension 50102 "SO Processor WebShop Ext" extends "Sales Order Processor"
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