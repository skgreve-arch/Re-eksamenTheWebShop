tableextension 50101 "Item WebShop Ext" extends Item
{
    fields
    {
        field(50100; "Sales Channel"; Option)
        {
            Caption = 'Sales Channel';
            OptionCaption = ' ,Web Shop,Physical Store,Both';
            OptionMembers = " ","Web Shop","Physical Store","Both";
            DataClassification = CustomerContent;
        }
        field(50101; "WooCommerce Product ID"; Integer)
        {
            Caption = 'WooCommerce Product ID';
            DataClassification = CustomerContent;
        }
    }
}