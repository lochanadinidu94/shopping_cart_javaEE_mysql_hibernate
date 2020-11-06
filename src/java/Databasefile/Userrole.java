package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Userrole generated by hbm2java
 */
public class Userrole  implements java.io.Serializable {


     private Integer idUserRole;
     private User user;
     private Set pageses = new HashSet(0);

    public Userrole() {
    }

	
    public Userrole(User user) {
        this.user = user;
    }
    public Userrole(User user, Set pageses) {
       this.user = user;
       this.pageses = pageses;
    }
   
    public Integer getIdUserRole() {
        return this.idUserRole;
    }
    
    public void setIdUserRole(Integer idUserRole) {
        this.idUserRole = idUserRole;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Set getPageses() {
        return this.pageses;
    }
    
    public void setPageses(Set pageses) {
        this.pageses = pageses;
    }




}

