package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1



/**
 * Status generated by hbm2java
 */
public class Status  implements java.io.Serializable {


     private Integer idStatus;
     private Admin admin;
     private String status;

    public Status() {
    }

	
    public Status(Admin admin) {
        this.admin = admin;
    }
    public Status(Admin admin, String status) {
       this.admin = admin;
       this.status = status;
    }
   
    public Integer getIdStatus() {
        return this.idStatus;
    }
    
    public void setIdStatus(Integer idStatus) {
        this.idStatus = idStatus;
    }
    public Admin getAdmin() {
        return this.admin;
    }
    
    public void setAdmin(Admin admin) {
        this.admin = admin;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }




}


