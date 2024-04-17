package data.dto;

public class CategoryDto {
	private int cate_num;
	private int parent_cate_num;
	private String cate_name;
	
	public int getCate_num() {
		return cate_num;
	}
	public void setCate_num(int cate_num) {
		this.cate_num = cate_num;
	}
	public int getParent_cate_num() {
		return parent_cate_num;
	}
	public void setParent_cate_num(int parent_cate_num) {
		this.parent_cate_num = parent_cate_num;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}

}
