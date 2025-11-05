package com.ems.model;

import java.util.Date;

public class ActivityLog {
	private int id;
	private String actionType;
	private String actionDescription;
	private String employeeName;
	private String adminUsername;
	private String adminFullname;
	private Date timestamp;
	
	
	public ActivityLog() {
	}


	public ActivityLog(String actionType, String actionDescription, String adminUsername, String adminFullname) {
		this.actionType = actionType;
		this.actionDescription = actionDescription;
		this.adminUsername = adminUsername;
		this.adminFullname = adminFullname;
		this.timestamp = new Date();
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getActionType() {
		return actionType;
	}


	public void setActionType(String actionType) {
		this.actionType = actionType;
	}


	public String getActionDescription() {
		return actionDescription;
	}


	public void setActionDescription(String actionDescription) {
		this.actionDescription = actionDescription;
	}


	public String getEmployeeName() {
		return employeeName;
	}


	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}


	public String getAdminUsername() {
		return adminUsername;
	}


	public void setAdminUsername(String adminUsername) {
		this.adminUsername = adminUsername;
	}
	
	public String getAdminFullname() {
        return adminFullname;
    }

    public void setAdminFullname(String adminFullname) {
        this.adminFullname = adminFullname;
    }

	public Date getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

}
