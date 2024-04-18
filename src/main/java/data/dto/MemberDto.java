package data.dto;

import java.sql.Timestamp;

public class MemberDto {

	private String mem_num;
	private String mem_id;
	private String mem_password;
	private String mem_name;
	private String mem_nickname;
	private String mem_hp;
	private String mem_zipcode;
	private String mem_address;
	private String mem_address_detail;
	private String mem_email;
	private String mem_birth;
	private String mem_gender;
	private Timestamp mem_gaipday;
	private String mem_is_active;

	public String getMem_num() {
		return mem_num;
	}

	public void setMem_num(String mem_num) {
		this.mem_num = mem_num;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_password() {
		return mem_password;
	}

	public void setMem_password(String mem_password) {
		this.mem_password = mem_password;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getMem_nickname() {
		return mem_nickname;
	}

	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}

	public String getMem_hp() {
		return mem_hp;
	}

	public void setMem_hp(String mem_hp) {
		this.mem_hp = mem_hp;
	}

	public String getMem_zipcode() {
		return mem_zipcode;
	}

	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}

	public String getMem_address() {
		return mem_address;
	}

	public void setMem_address(String mem_address) {
		this.mem_address = mem_address;
	}

	public String getMem_address_detail() {
		return mem_address_detail;
	}

	public void setMem_address_detail(String mem_address_detail) {
		this.mem_address_detail = mem_address_detail;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public String getMem_birth() {
		return mem_birth;
	}

	public void setMem_birth(String mem_birth) {
		this.mem_birth = mem_birth;
	}

	public String getMem_gender() {
		return mem_gender;
	}

	public void setMem_gender(String mem_gender) {
		this.mem_gender = mem_gender;
	}

	public Timestamp getMem_gaipday() {
		return mem_gaipday;
	}

	public void setMem_gaipday(Timestamp mem_gaipday) {
		this.mem_gaipday = mem_gaipday;
	}

	public String getMem_is_active() {
		return mem_is_active;
	}

	public void setMem_is_active(String mem_is_active) {
		this.mem_is_active = mem_is_active;
	}

}
