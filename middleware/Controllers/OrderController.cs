[ApiController]
[Route("api/[controller]")]
public class OrderController : ControllerBase
{
    // WooCommerce sender hertil ved nyt køb
    // URL konfigureres i WooCommerce webhook:
    // http://localhost:5000/api/order/woo-webhook
    
    [HttpPost("woo-webhook")]
    public async Task<IActionResult> ReceiveOrder([FromBody] WooOrder order)
    {
        var bcUrl = "http://sebkgreve2025:8080/BC210/api/v2.0/companies(...)";
        
        using var client = new HttpClient();
        
        foreach (var line in order.LineItems)
        {
            var payload = new {
                customerEmail = order.Billing.Email,
                wooProductId  = line.ProductId,
                quantity      = line.Quantity,
                orderReference = "WOO-" + order.Id
            };
            
            await client.PostAsJsonAsync(
                bcUrl + "/wooOrders", payload);
        }
        
        return Ok();
    }
}

// Model der matcher WooCommerce JSON
public class WooOrder
{
    public int Id { get; set; }
    public WooBilling Billing { get; set; }
    public List<WooLineItem> LineItems { get; set; }
}
public class WooBilling { public string Email { get; set; } }
public class WooLineItem { public int ProductId { get; set; } public int Quantity { get; set; } }