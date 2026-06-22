codeunit 50102 "Stock Check Job"
{
    // Denne codeunit køres af Job Queue
    trigger OnRun()
    begin
        CheckLowStock();
    end;

    local procedure CheckLowStock()
    var
        Item: Record Item;
        Setup: Record "WebShop Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        LowStockItems: Text;
        Threshold: Integer;
    begin
        if not Setup.Get('') then
            exit;

        Threshold := Setup."Low Stock Threshold";
        LowStockItems := '';

        Item.SetRange("Sales Channel", Item."Sales Channel"::"Web Shop");
        Item.SetFilter(Inventory, '<%1', Threshold);
        if Item.FindSet() then
            repeat
                LowStockItems += Item."No." + ' - ' + Item.Description +
                                  ' (Lager: ' + Format(Item.Inventory) + ')\n';
            until Item.Next() = 0;

        if LowStockItems <> '' then begin
            EmailMessage.Create(
                Setup."Notification Email",
                'ADVARSEL: Lavt lager på webshop-varer',
                'Følgende varer er under lagergrænsen (' + Format(Threshold) + '):\n\n' + LowStockItems,
                true);
            Email.Send(EmailMessage);
        end;
    end;
}