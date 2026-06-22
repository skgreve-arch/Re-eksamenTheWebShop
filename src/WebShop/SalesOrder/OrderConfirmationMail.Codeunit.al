codeunit 50101 "Order Confirmation Mail"
{
    procedure SendConfirmation(SalesHeader: Record "Sales Header"; RecipientEmail: Text)
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Body: Text;
    begin
        Body := 'Kære kunde,\n\nTak for din ordre nr. ' + SalesHeader."No." +
                '.\n\nMed venlig hilsen,\nWebShop';

        EmailMessage.Create(RecipientEmail,
                            'Ordrebekræftelse - ' + SalesHeader."No.",
                            Body,
                            true);

        Email.Send(EmailMessage);
    end;
}