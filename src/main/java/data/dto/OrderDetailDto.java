package data.dto;

public class OrderDetailDto {
	private String memNum;
    private String proNum;
    private String orderNum;
    private int orderDetailSu;
    
	public String getMemNum() {
		return memNum;
	}
	public void setMemNum(String memNum) {
		this.memNum = memNum;
	}
	public String getProNum() {
		return proNum;
	}
	public void setProNum(String proNum) {
		this.proNum = proNum;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public int getOrderDetailSu() {
		return orderDetailSu;
	}
	public void setOrderDetailSu(int orderDetailSu) {
		this.orderDetailSu = orderDetailSu;
	}
    
}