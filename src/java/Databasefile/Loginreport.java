package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * Loginreport generated by hbm2java
 */
public class Loginreport  implements java.io.Serializable {


     private Integer idLoginReport;
     private User user;
     private String date;
     private Date inTime;
     private Date outTime;

    public Loginreport() {
    }

	
    public Loginreport(User user) {
        this.user = user;
    }
    public Loginreport(User user, String date, Date inTime, Date outTime) {
       this.user = user;
       this.date = date;
       this.inTime = inTime;
       this.outTime = outTime;
    }
   
    public Integer getIdLoginReport() {
        return this.idLoginReport;
    }
    
    public void setIdLoginReport(Integer idLoginReport) {
        this.idLoginReport = idLoginReport;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public Date getInTime() {
        return this.inTime;
    }
    
    public void setInTime(Date inTime) {
        this.inTime = inTime;
    }
    public Date getOutTime() {
        return this.outTime;
    }
    
    public void setOutTime(Date outTime) {
        this.outTime = outTime;
    }




}


