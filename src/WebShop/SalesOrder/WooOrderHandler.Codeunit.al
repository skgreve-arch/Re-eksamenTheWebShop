codeunit 50100 "Woo Order Handler"
{
    procedure CreateSalesOrderFromWoo(
        CustomerEmail: Text;
        WooProductId: Integer;
        Qty: Integer;
        OrderRef: Text[50])
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        Item: Record Item;
        MailSender: Codeunit "Order Confirmation Mail";
    begin
        Item.SetRange("WooCommerce Product ID", WooProductId);
        if not Item.FindFirst() then
            Error('Vare med WooCommerce ID %1 ikke fundet.', WooProductId);

        Customer.SetRange("E-Mail", CustomerEmail);
        if not Customer.FindFirst() then
            Error('Kunde %1 ikke fundet.', CustomerEmail);

        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", Customer."No.");
        SalesHeader."External Document No." := OrderRef;
        SalesHeader.Modify(true);

        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := 10000;
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine.Validate("No.", Item."No.");
        SalesLine.Validate(Quantity, Qty);
        SalesLine.Insert(true);

        MailSender.SendConfirmation(SalesHeader, CustomerEmail);
    end;
}