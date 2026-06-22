page 50101 "Product Sales Chart"
{
    Caption = 'Webshop Salg pr. Produkt';
    PageType = CardPart;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            usercontrol(SalesChart; BusinessChart)
            {
                ApplicationArea = All;

                trigger DataPointClicked(Point: JsonObject)
                var
                    ItemNoToken: JsonToken;
                    Item: Record Item;
                    ItemCard: Page "Item Card";
                begin
                    if Point.Get('XValueString', ItemNoToken) then
                        if Item.Get(ItemNoToken.AsValue().AsText()) then begin
                            ItemCard.SetRecord(Item);
                            ItemCard.Run();
                        end;
                end;

                trigger AddInReady()
                begin
                    BuildChart();
                end;
            }
        }
    }

    local procedure BuildChart()
    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
        BusChartBuf: Record "Business Chart Buffer";
    begin
        BusChartBuf.Initialize();
        BusChartBuf.AddMeasure(
            'Solgt antal', 1,
            BusChartBuf."Data Type"::Decimal,
            BusChartBuf."Chart Type"::Column);

        Item.SetFilter("Sales Channel", '<>%1', Item."Sales Channel"::" ");
        if Item.FindSet() then
            repeat
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                SalesLine.SetRange("No.", Item."No.");
                SalesLine.CalcSums(Quantity);

                BusChartBuf.AddColumn(Item."No.");
                BusChartBuf.SetValue('Solgt antal', BusChartBuf.Column - 1, SalesLine.Quantity);
            until Item.Next() = 0;

        CurrPage.SalesChart.Update(BusChartBuf);
    end;
}