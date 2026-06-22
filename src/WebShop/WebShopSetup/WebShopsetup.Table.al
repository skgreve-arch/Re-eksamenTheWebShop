table 50100 "WebShop Setup"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Primary Key"; Code[10]) { }
        field(2; "Low Stock Threshold"; Integer) { InitValue = 5; }
        field(3; "Notification Email"; Text[100]) { }
    }
    keys { key(PK; "Primary Key") { Clustered = true; } }
}