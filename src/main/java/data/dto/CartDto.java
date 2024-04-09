package data.dto;

public class CartDto {
	
	private int cart_num;
	private int pro_num;
	private int mem_num;
	private int cart_su;
	private String cart_size;
	private String cart_color;
	
	public String getCart_size() {
		return cart_size;
	}
	public void setCart_size(String cart_size) {
		this.cart_size = cart_size;
	}
	public String getCart_color() {
		return cart_color;
	}
	public void setCart_color(String cart_color) {
		this.cart_color = cart_color;
	}
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
	public int getPro_num() {
		return pro_num;
	}
	public void setPro_num(int pro_num) {
		this.pro_num = pro_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getCart_su() {
		return cart_su;
	}
	public void setCart_su(int cart_su) {
		this.cart_su = cart_su;
	}
	
	
}
