public class BusinessCentralService
{
    private readonly HttpClient _httpClient;
    private readonly string _bcBaseUrl;

    public async Task CreateSalesOrderAsync(
        string email, int wooProductId, int qty, string orderRef)
    {
        var payload = new {
            customerEmail = email,
            wooProductId = wooProductId,
            quantity = qty,
            orderReference = orderRef
        };

        await _httpClient.PostAsJsonAsync(
            $"{_bcBaseUrl}/api/v2.0/companies(...)/wooOrders", 
            payload);
    }
}