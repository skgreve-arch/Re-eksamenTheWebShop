codeunit 50190 "Woo Order Handler Test"
{
    Subtype = Test;

    [Test]
    procedure TestCreateOrder_ValidProduct()
    var
        Item: Record Item;
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        Handler: Codeunit "Woo Order Handler";
    begin
        // Arrange
        LibraryInventory.CreateItem(Item);
        Item."WooCommerce Product ID" := 99901;
        Item."Sales Channel" := Item."Sales Channel"::"Web Shop";
        Item.Modify();

        LibrarySales.CreateCustomer(Customer);
        Customer."E-Mail" := 'test@webshop.dk';
        Customer.Modify();

        // Act
        Handler.CreateSalesOrderFromWoo('test@webshop.dk', 99901, 2, 'WOO-TEST-001');

        // Assert
        SalesHeader.SetRange("External Document No.", 'WOO-TEST-001');
        Assert.IsTrue(SalesHeader.FindFirst(), 'Salgsordre ikke oprettet');
    end;

    [Test]
    procedure TestCreateOrder_UgyldigtProduktID()
    var
        Handler: Codeunit "Woo Order Handler";
    begin
        asserterror Handler.CreateSalesOrderFromWoo('x@x.dk', 0, 1, 'WOO-ERR');
        Assert.ExpectedError('Vare med WooCommerce ID');
    end;

    var
        LibraryInventory: Codeunit "Library - Inventory";
        LibrarySales: Codeunit "Library - Sales";
        Assert: Codeunit Assert;
}