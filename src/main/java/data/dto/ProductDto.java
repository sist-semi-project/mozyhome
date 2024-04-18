package data.dto;

import java.sql.Timestamp;

public class ProductDto {
    private String pro_num;
    private String cate_num;
    private String pro_name;
    private String pro_explain;
    private int pro_stock;
    private int pro_price;
    private String pro_size;
    private String pro_color;
    private String pro_main_img;
    private String pro_sub_img1;
    private String pro_sub_img2;
    private String pro_sub_img3;
    private String pro_sub_img4;
    private String pro_sub_img5;
    private Timestamp pro_create_date;
    private String pro_sale_status;
    private int pro_sale_volume;
    private String parent_cate_num;
    private int totalCount;
    private int wishCount;
    private int reviewCount;
    private String mem_id; // 상품리스트 안에 위시리스트 id (0415 추가)

    public String getPro_num() {
        return pro_num;
    }

    public void setPro_num(String pro_num) {
        this.pro_num = pro_num;
    }

    public String getCate_num() {
        return cate_num;
    }

    public void setCate_num(String cate_num) {
        this.cate_num = cate_num;
    }

    public String getPro_name() {
        return pro_name;
    }

    public void setPro_name(String pro_name) {
        this.pro_name = pro_name;
    }

    public String getPro_explain() {
        return pro_explain;
    }

    public void setPro_explain(String pro_explain) {
        this.pro_explain = pro_explain;
    }

    public int getPro_stock() {
        return pro_stock;
    }

    public void setPro_stock(int pro_stock) {
        this.pro_stock = pro_stock;
    }

    public int getPro_price() {
        return pro_price;
    }

    public void setPro_price(int pro_price) {
        this.pro_price = pro_price;
    }

    public String getPro_main_img() {
        return pro_main_img;
    }

    public void setPro_main_img(String pro_main_img) {
        this.pro_main_img = pro_main_img;
    }

    public String getPro_sub_img1() {
        return pro_sub_img1;
    }

    public void setPro_sub_img1(String pro_sub_img1) {
        this.pro_sub_img1 = pro_sub_img1;
    }

    public String getPro_sub_img2() {
        return pro_sub_img2;
    }

    public void setPro_sub_img2(String pro_sub_img2) {
        this.pro_sub_img2 = pro_sub_img2;
    }

    public String getPro_sub_img3() {
        return pro_sub_img3;
    }

    public void setPro_sub_img3(String pro_sub_img3) {
        this.pro_sub_img3 = pro_sub_img3;
    }

    public String getPro_sub_img4() {
        return pro_sub_img4;
    }

    public void setPro_sub_img4(String pro_sub_img4) {
        this.pro_sub_img4 = pro_sub_img4;
    }

    public String getPro_sub_img5() {
        return pro_sub_img5;
    }

    public void setPro_sub_img5(String pro_sub_img5) {
        this.pro_sub_img5 = pro_sub_img5;
    }

    public Timestamp getPro_create_date() {
        return pro_create_date;
    }

    public void setPro_create_date(Timestamp pro_create_date) {
        this.pro_create_date = pro_create_date;
    }

    public String getPro_sale_status() {
        return pro_sale_status;
    }

    public void setPro_sale_status(String pro_sale_status) {
        this.pro_sale_status = pro_sale_status;
    }

	public String getPro_size() {
		return pro_size;
	}

	public void setPro_size(String pro_size) {
		this.pro_size = pro_size;
	}

	public String getPro_color() {
		return pro_color;
	}

	public void setPro_color(String pro_color) {
		this.pro_color = pro_color;
	}

    public int getPro_sale_volume() {
        return pro_sale_volume;
    }

    public void setPro_sale_volume(int pro_sale_volume) {
        this.pro_sale_volume = pro_sale_volume;
    }

    public String getParent_cate_num() {
        return parent_cate_num;
    }

    public void setParent_cate_num(String parent_cate_num) {
        this.parent_cate_num = parent_cate_num;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

	public int getWishCount() {
		return wishCount;
	}

	public void setWishCount(int wishCount) {
		this.wishCount = wishCount;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	

    
}