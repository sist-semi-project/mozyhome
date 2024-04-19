package data.dto;

public class OrderDetailDto {
	private String mem_num ;
	private String order_num;
    private String pro_num;
    private int order_detail_su;
    
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
    
}