package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Sizetype generated by hbm2java
 */
public class Sizetype  implements java.io.Serializable {


     private Integer idSizeType;
     private String name;
     private Set sizes = new HashSet(0);

    public Sizetype() {
    }

    public Sizetype(String name, Set sizes) {
       this.name = name;
       this.sizes = sizes;
    }
   
    public Integer getIdSizeType() {
        return this.idSizeType;
    }
    
    public void setIdSizeType(Integer idSizeType) {
        this.idSizeType = idSizeType;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Set getSizes() {
        return this.sizes;
    }
    
    public void setSizes(Set sizes) {
        this.sizes = sizes;
    }




}


