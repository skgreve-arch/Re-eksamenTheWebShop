codeunit 50101 "Order Confirmation Mail"
{
    procedure SendConfirmation(SalesHeader: Record "Sales Header"; RecipientEmail: Text)
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        EmailMessage.Create(
            RecipientEmail,
            'Ordrebekræftelse - ' + SalesHeader."No.",
            'Tak for din ordre nr. ' + SalesHeader."No." + '. Vi behandler den hurtigst muligt.',
            true);
        Email.Send(EmailMessage);
    end;
}