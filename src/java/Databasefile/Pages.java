package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Pages generated by hbm2java
 */
public class Pages  implements java.io.Serializable {


     private Integer idPages;
     private String pageName;
     private Set userroles = new HashSet(0);

    public Pages() {
    }

    public Pages(String pageName, Set userroles) {
       this.pageName = pageName;
       this.userroles = userroles;
    }
   
    public Integer getIdPages() {
        return this.idPages;
    }
    
    public void setIdPages(Integer idPages) {
        this.idPages = idPages;
    }
    public String getPageName() {
        return this.pageName;
    }
    
    public void setPageName(String pageName) {
        this.pageName = pageName;
    }
    public Set getUserroles() {
        return this.userroles;
    }
    
    public void setUserroles(Set userroles) {
        this.userroles = userroles;
    }




}


