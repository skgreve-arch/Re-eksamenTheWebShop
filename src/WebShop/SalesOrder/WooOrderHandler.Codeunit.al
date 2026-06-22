codeunit 50100 "Woo Order Handler"
{
    procedure CreateSalesOrderFromWoo(
        CustomerEmail: Text;
        WooProductId: Integer;
        Quantity: Integer;
        OrderReference: Text[50])
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        Item: Record Item;
        MailSender: Codeunit "Order Confirmation Mail";
    begin
        // Find item via WooCommerce ID
        Item.SetRange("WooCommerce Product ID", WooProductId);
        if not Item.FindFirst() then
            Error('Vare med WooCommerce ID %1 ikke fundet.', WooProductId);

        // Find eller opret kunde baseret på email
        // (forenklet – i produktion ville man bruge en customer-lookup)
        Customer.SetRange("E-Mail", CustomerEmail);
        if not Customer.FindFirst() then
            Error('Kunde med email %1 ikke fundet.', CustomerEmail);

        // Opret salgsordrehoved
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", Customer."No.");
        SalesHeader."External Document No." := OrderReference;
        SalesHeader.Modify(true);

        // Opret salgslinje
        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := 10000;
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine.Validate("No.", Item."No.");
        SalesLine.Validate(Quantity, Quantity);
        SalesLine.Insert(true);

        // Send ordrebekræftelse
        MailSender.SendConfirmation(SalesHeader, CustomerEmail);
    end;
}