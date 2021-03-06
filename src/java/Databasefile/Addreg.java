package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Addreg generated by hbm2java
 */
public class Addreg  implements java.io.Serializable {


     private Integer idAddreg;
     private User user;
     private String plan;
     private String reason;
     private Date expdate;
     private String states;
     private Set images = new HashSet(0);
     private Set addinvoices = new HashSet(0);

    public Addreg() {
    }

	
    public Addreg(User user) {
        this.user = user;
    }
    public Addreg(User user, String plan, String reason, Date expdate, String states, Set images, Set addinvoices) {
       this.user = user;
       this.plan = plan;
       this.reason = reason;
       this.expdate = expdate;
       this.states = states;
       this.images = images;
       this.addinvoices = addinvoices;
    }
   
    public Integer getIdAddreg() {
        return this.idAddreg;
    }
    
    public void setIdAddreg(Integer idAddreg) {
        this.idAddreg = idAddreg;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getPlan() {
        return this.plan;
    }
    
    public void setPlan(String plan) {
        this.plan = plan;
    }
    public String getReason() {
        return this.reason;
    }
    
    public void setReason(String reason) {
        this.reason = reason;
    }
    public Date getExpdate() {
        return this.expdate;
    }
    
    public void setExpdate(Date expdate) {
        this.expdate = expdate;
    }
    public String getStates() {
        return this.states;
    }
    
    public void setStates(String states) {
        this.states = states;
    }
    public Set getImages() {
        return this.images;
    }
    
    public void setImages(Set images) {
        this.images = images;
    }
    public Set getAddinvoices() {
        return this.addinvoices;
    }
    
    public void setAddinvoices(Set addinvoices) {
        this.addinvoices = addinvoices;
    }




}


