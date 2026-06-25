package model;

public class Item {
    private Product product;
    private int quantity;
    private String size;
    private String color;
    private double price;

    public Item() {}

    public Item(Product product, int quantity, String size, String color, double price) {
        this.product = product;
        this.quantity = quantity;
        this.size = size;
        this.color = color;
        this.price = price;
    }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}