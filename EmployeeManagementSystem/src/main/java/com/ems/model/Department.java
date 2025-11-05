package com.ems.model;

public class Department {
    private int id;
    private String name;
    private String code;
    private String manager;
    private String location;
    private String description;
    private int employeeCount;
    
    public Department() {}
    
    public Department(int id, String name, String code, String manager, String location, String description, int employeeCount) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.manager = manager;
        this.location = location;
        this.description = description;
        this.employeeCount = employeeCount;
    }
    

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    
    public String getManager() { return manager; }
    public void setManager(String manager) { this.manager = manager; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public int getEmployeeCount() { return employeeCount; }
    public void setEmployeeCount(int employeeCount) { this.employeeCount = employeeCount; }
}