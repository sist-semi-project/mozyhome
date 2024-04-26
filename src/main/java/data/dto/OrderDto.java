package data.dto;

import java.sql.Timestamp;

public class OrderDto {
	private String order_num;
    private String mem_num;
    private Timestamp order_date;
    private String order_status;
    private String order_delivery_request;
    private String order_addr;
    private String order_name;
    private String order_hp;
    private int order_delivery_fee;
    private int order_total_payment;
	private String mem_name;
	private String pro_name;
	private int totalCount;
    
	public String getOrder_num() {
		return order_num;
	}
	public void setOrder_num(String order_num) {
		this.order_num = order_num;
	}
	public String getMem_num() {
		return mem_num;
	}
	public void setMem_num(String mem_num) {
		this.mem_num = mem_num;
	}
	public Timestamp getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Timestamp order_date) {
		this.order_date = order_date;
	}
	public String getOrder_status() {
		return order_status;
	}
	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}
	public String getOrder_delivery_request() {
		return order_delivery_request;
	}
	public void setOrder_delivery_request(String order_delivery_request) {
		this.order_delivery_request = order_delivery_request;
	}
	public String getOrder_addr() {
		return order_addr;
	}
	public void setOrder_addr(String order_addr) {
		this.order_addr = order_addr;
	}
	public String getOrder_name() {
		return order_name;
	}
	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}
	public String getOrder_hp() {
		return order_hp;
	}
	public void setOrder_hp(String order_hp) {
		this.order_hp = order_hp;
	}
	public int getOrder_delivery_fee() {
		return order_delivery_fee;
	}
	public void setOrder_delivery_fee(int order_delivery_fee) {
		this.order_delivery_fee = order_delivery_fee;
	}
	public int getOrder_total_payment() {
		return order_total_payment;
	}
	public void setOrder_total_payment(int order_total_payment) {
		this.order_total_payment = order_total_payment;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
}