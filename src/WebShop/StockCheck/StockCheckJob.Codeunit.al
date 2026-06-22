codeunit 50102 "Stock Check Job"
{
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
    begin
        if not Setup.Get('') then exit;

        Item.SetRange("Sales Channel", Item."Sales Channel"::"Web Shop");
        Item.SetFilter(Inventory, '<%1', Setup."Low Stock Threshold");
        if Item.FindSet() then
            repeat
                LowStockItems += Item."No." + ' - ' + Item.Description +
                                  ' (Lager: ' + Format(Item.Inventory) + ')' + '<br>';
            until Item.Next() = 0;

        if LowStockItems <> '' then begin
            EmailMessage.Create(
                Setup."Notification Email",
                'ADVARSEL: Lavt lager på webshop-varer',
                'Følgende varer er under grænsen:<br><br>' + LowStockItems,
                true);
            Email.Send(EmailMessage);
        end;
    end;
}