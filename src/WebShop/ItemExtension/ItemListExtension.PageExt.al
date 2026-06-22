pageextension 50101 "Item List WebShop Ext" extends "Item List"
{
    layout
    {
        addafter("Unit Price")
        {
            field("Sales Channel"; Rec."Sales Channel")
            {
                ApplicationArea = All;
                Caption = 'Sales Channel';
            }
        }
    }
}