page 50101 "Product Sales Chart"
{
    Caption = 'Solgte produkter (Webshop)';
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
                    ItemNo: Text;
                    Item: Record Item;
                    ItemCard: Page "Item Card";
                begin
                    // Når bruger klikker på en søjle, åbn Item Card
                    Point.Get('XValueString', ItemNo);  // eller brug index afhængigt af opsætning
                    if Item.Get(ItemNo) then begin
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
        BusinessChartBuffer: Record "Business Chart Buffer";
        BusChartBuf: Record "Business Chart Buffer";
        QtyIndex: Integer;
    begin
        BusinessChartBuffer.Initialize();
        BusinessChartBuffer.AddMeasure('Solgt antal', 1,
            BusinessChartBuffer."Data Type"::Decimal,
            BusinessChartBuffer."Chart Type"::Column);

        Item.SetFilter("Sales Channel", '<>%1', Item."Sales Channel"::" ");
        if Item.FindSet() then
            repeat
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                SalesLine.SetRange("No.", Item."No.");
                SalesLine.CalcSums(Quantity);

                BusinessChartBuffer.AddColumn(Item."No." + ' ' + Item.Description);
                BusinessChartBuffer.SetValue('Solgt antal',
                    BusinessChartBuffer.Column - 1,
                    SalesLine.Quantity);
            until Item.Next() = 0;

        CurrPage.SalesChart.Update(BusinessChartBuffer);
    end;
}