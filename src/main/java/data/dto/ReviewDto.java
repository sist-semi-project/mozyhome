package data.dto;

import java.sql.Timestamp;

public class ReviewDto {

		private int review_num;
		private int mem_num;
		private int pro_num;
		private int review_pyung;
		private String review_content;
		private String review_image;
		private Timestamp review_writeday;
		
		public int getReview_num() {
			return review_num;
		}
		public void setReview_num(int review_num) {
			this.review_num = review_num;
		}
		public int getMem_num() {
			return mem_num;
		}
		public void setMem_num(int mem_num) {
			this.mem_num = mem_num;
		}
		public int getPro_num() {
			return pro_num;
		}
		public void setPro_num(int pro_num) {
			this.pro_num = pro_num;
		}
		public int getReview_pyung() {
			return review_pyung;
		}
		public void setReview_pyung(int review_pyung) {
			this.review_pyung = review_pyung;
		}
		public String getReview_content() {
			return review_content;
		}
		public void setReview_content(String review_content) {
			this.review_content = review_content;
		}
		public String getReview_image() {
			return review_image;
		}
		public void setReview_image(String review_image) {
			this.review_image = review_image;
		}
		public Timestamp getReview_writeday() {
			return review_writeday;
		}
		public void setReview_writeday(Timestamp review_writeday) {
			this.review_writeday = review_writeday;
		}
		
		
		
}
