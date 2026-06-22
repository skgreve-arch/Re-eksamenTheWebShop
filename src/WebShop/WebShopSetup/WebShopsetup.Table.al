table 50100 "WebShop Setup"
{
    Caption = 'WebShop Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10]) { Caption = 'Primary Key'; }
        field(2; "Low Stock Threshold"; Integer)
        {
            Caption = 'Low Stock Threshold';
            InitValue = 5;
        }
        field(3; "Notification Email"; Text[100]) { Caption = 'Notification Email'; }
        field(4; "WooCommerce API URL"; Text[250]) { Caption = 'WooCommerce API URL'; }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}