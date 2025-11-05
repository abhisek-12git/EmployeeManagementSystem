package com.ems.service;

import com.ems.dao.ReportDao;
import com.ems.model.Report;

public class ReportService {
	
	private ReportDao reportDao;
	
	public ReportService() {
		this.reportDao = new ReportDao();
	}
	
	public Report getDashboardReports() {
		return reportDao.getDashboardReports();
	}
	
	public Report getReportsByDepartment(String department) {
		Report allReports = reportDao.getDashboardReports();
		return allReports;
	}
	
	public Report getReportsByDateRange(String startDate, String endDate) {
		Report allReports = reportDao.getDashboardReports();
		return allReports;
	}

}
