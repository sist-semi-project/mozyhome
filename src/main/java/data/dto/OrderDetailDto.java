package data.dto;

public class OrderDetailDto {
	private String mem_num ;
	private String order_num;
    private String pro_num;
    private String order_size;
    private String order_color;
    private int order_detail_su;
	private String pro_name;
	private int pro_price;
	private String pro_main_image;
    
    
	public String getOrder_size() {
		return order_size;
	}
	public void setOrder_size(String order_size) {
		this.order_size = order_size;
	}
	public String getOrder_color() {
		return order_color;
	}
	public void setOrder_color(String order_color) {
		this.order_color = order_color;
	}
	public String getMem_num() {
		return mem_num;
	}
	public void setMem_num(String mem_num) {
		this.mem_num = mem_num;
	}
	public String getOrder_num() {
		return order_num;
	}
	public void setOrder_num(String order_num) {
		this.order_num = order_num;
	}
	public String getPro_num() {
		return pro_num;
	}
	public void setPro_num(String pro_num) {
		this.pro_num = pro_num;
	}
	public int getOrder_detail_su() {
		return order_detail_su;
	}
	public void setOrder_detail_su(int order_detail_su) {
		this.order_detail_su = order_detail_su;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public int getPro_price() {
		return pro_price;
	}
	public void setPro_price(int pro_price) {
		this.pro_price = pro_price;
	}
	public String getPro_main_image() {
		return pro_main_image;
	}
	public void setPro_main_image(String pro_main_image) {
		this.pro_main_image = pro_main_image;
	}
}