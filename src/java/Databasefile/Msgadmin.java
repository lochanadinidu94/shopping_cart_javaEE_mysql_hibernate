package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * Msgadmin generated by hbm2java
 */
public class Msgadmin  implements java.io.Serializable {


     private Integer idMsgadmin;
     private String msg;
     private Date date;

    public Msgadmin() {
    }

    public Msgadmin(String msg, Date date) {
       this.msg = msg;
       this.date = date;
    }
   
    public Integer getIdMsgadmin() {
        return this.idMsgadmin;
    }
    
    public void setIdMsgadmin(Integer idMsgadmin) {
        this.idMsgadmin = idMsgadmin;
    }
    public String getMsg() {
        return this.msg;
    }
    
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }




}

