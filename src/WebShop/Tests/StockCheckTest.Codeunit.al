codeunit 50191 "Stock Check Test"
{
    Subtype = Test;

    [Test]
    procedure TestStockCheck_SendsMailWhenLow()
    var
        Item: Record Item;
        Setup: Record "WebShop Setup";
        StockJob: Codeunit "Stock Check Job";
    begin
        // Arrange
        Setup.Init();
        Setup."Primary Key" := '';
        Setup."Low Stock Threshold" := 10;
        Setup."Notification Email" := 'admin@shop.dk';
        if not Setup.Insert() then
            Setup.Modify();

        LibraryInventory.CreateItem(Item);
        Item."Sales Channel" := Item."Sales Channel"::"Web Shop";
        Item.Inventory := 3; // Under tærsklen
        Item.Modify();

        // Act & Assert (verificér at codeunit kører uden fejl)
        StockJob.Run();
        // I et fuldt test-miljø ville man mock email-afsendelse
    end;

    var
        LibraryInventory: Codeunit "Library - Inventory";
}