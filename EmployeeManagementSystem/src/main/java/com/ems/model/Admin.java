package com.ems.model;

public class Admin {
	
	private int id;
	private String fullname;
	private String username;
	private String email;
	private String phone;
	private String password;
	private String profilePicture;
	
	public Admin() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getProfilePicture() {
		return profilePicture;
	}

	public void setProfilePicture(String profilePicture) {
		this.profilePicture = profilePicture;
	}
	
	public String getInitials() {
		if(fullname == null || fullname.trim().isEmpty()) {
			return "U";
		}
		
		
		String[] parts = fullname.trim().split("\\s+");
		String initials = "";
		if(parts.length > 0) {
			initials += parts[0].substring(0,1).toUpperCase();
		}
		if(parts.length > 1) {
			initials += parts[parts.length - 1].substring(0,1).toUpperCase();
		}
		
		return initials;
	}
	
}
