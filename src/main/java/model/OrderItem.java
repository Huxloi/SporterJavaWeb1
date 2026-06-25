package model;

public class OrderItem {
    private int id;
    private int orderId;
    private int productId;
    private String productName;
    private String productImg;
    private int quantity;
    private double priceAtPurchase;
    private String selectedSize;
    private String selectedColor;

    public OrderItem() {}

    public OrderItem(int id, int orderId, int productId, String productName, String productImg, int quantity, double priceAtPurchase, String selectedSize, String selectedColor) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.productName = productName;
        this.productImg = productImg;
        this.quantity = quantity;
        this.priceAtPurchase = priceAtPurchase;
        this.selectedSize = selectedSize;
        this.selectedColor = selectedColor;
    }

    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getProductImg() { return productImg; }
    public void setProductImg(String productImg) { this.productImg = productImg; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPriceAtPurchase() { return priceAtPurchase; }
    public void setPriceAtPurchase(double priceAtPurchase) { this.priceAtPurchase = priceAtPurchase; }
    public String getSelectedSize() { return selectedSize; }
    public void setSelectedSize(String selectedSize) { this.selectedSize = selectedSize; }
    public String getSelectedColor() { return selectedColor; }
    public void setSelectedColor(String selectedColor) { this.selectedColor = selectedColor; }
}