package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1



/**
 * Adminlogin generated by hbm2java
 */
public class Adminlogin  implements java.io.Serializable {


     private Integer idAdminLogin;
     private Admin admin;
     private String email;
     private String password;

    public Adminlogin() {
    }

	
    public Adminlogin(Admin admin) {
        this.admin = admin;
    }
    public Adminlogin(Admin admin, String email, String password) {
       this.admin = admin;
       this.email = email;
       this.password = password;
    }
   
    public Integer getIdAdminLogin() {
        return this.idAdminLogin;
    }
    
    public void setIdAdminLogin(Integer idAdminLogin) {
        this.idAdminLogin = idAdminLogin;
    }
    public Admin getAdmin() {
        return this.admin;
    }
    
    public void setAdmin(Admin admin) {
        this.admin = admin;
    }
    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }




}


