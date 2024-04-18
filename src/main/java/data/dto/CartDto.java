package data.dto;

public class CartDto {
    private int cartNum;
    private int proNum;
    private int memNum;
    private String cartSize;
    private String cartColor;
    private int cartSu;
    private String proName;

    public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	// 생성자
    public CartDto(int cartNum, int proNum, int memNum, String cartSize, String cartColor, int cartSu) {
        this.cartNum = cartNum;
        this.proNum = proNum;
        this.memNum = memNum;
        this.cartSize = cartSize;
        this.cartColor = cartColor;
        this.cartSu = cartSu;
    }

    public int getCartNum() {
        return cartNum;
    }

    public void setCartNum(int cartNum) {
        this.cartNum = cartNum;
    }

    public int getProNum() {
        return proNum;
    }

    public void setProNum(int proNum) {
        this.proNum = proNum;
    }

    public int getMemNum() {
        return memNum;
    }

    public void setMemNum(int memNum) {
        this.memNum = memNum;
    }

    public String getCartSize() {
        return cartSize;
    }

    public void setCartSize(String cartSize) {
        this.cartSize = cartSize;
    }

    public String getCartColor() {
        return cartColor;
    }

    public void setCartColor(String cartColor) {
        this.cartColor = cartColor;
    }

    public int getCartSu() {
        return cartSu;
    }

    public void setCartSu(int cartSu) {
        this.cartSu = cartSu;
    }
}