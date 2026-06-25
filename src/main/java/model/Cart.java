package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<Item> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public List<Item> getItems() {
        return items;
    }

    // Hàm kiểm tra xem món hàng (cùng ID, size, màu) đã có trong giỏ chưa
    private Item getItemByIdSizeColor(int id, String size, String color) {
        for (Item i : items) {
            if (i.getProduct().getId() == id && i.getSize().equals(size) && i.getColor().equals(color)) {
                return i;
            }
        }
        return null;
    }

    // Thêm vào giỏ
    public void addItem(Item t) {
        Item existItem = getItemByIdSizeColor(t.getProduct().getId(), t.getSize(), t.getColor());
        if (existItem != null) {
            // Nếu có rồi thì cộng dồn số lượng
            existItem.setQuantity(existItem.getQuantity() + t.getQuantity());
        } else {
            // Nếu chưa có thì thêm mới
            items.add(t);
        }
    }

    // Xóa khỏi giỏ
    public void removeItem(int id, String size, String color) {
        Item itemToRemove = getItemByIdSizeColor(id, size, color);
        if (itemToRemove != null) {
            items.remove(itemToRemove);
        }
    }

    // Tính tổng tiền toàn bộ giỏ hàng
    public double getTotalMoney() {
        double total = 0;
        for (Item i : items) {
            total += (i.getQuantity() * i.getPrice());
        }
        return total;
    }
}