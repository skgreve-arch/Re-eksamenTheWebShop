page 50100 "WebShop Setup Card"
{
    PageType = Card;
    SourceTable = "WebShop Setup";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Low Stock Threshold"; Rec."Low Stock Threshold") { ApplicationArea = All; }
                field("Notification Email"; Rec."Notification Email") { ApplicationArea = All; }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('') then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}