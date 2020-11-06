package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Size generated by hbm2java
 */
public class Size  implements java.io.Serializable {


     private Integer idSize;
     private Sizetype sizetype;
     private String name;
     private Set products = new HashSet(0);

    public Size() {
    }

	
    public Size(Sizetype sizetype) {
        this.sizetype = sizetype;
    }
    public Size(Sizetype sizetype, String name, Set products) {
       this.sizetype = sizetype;
       this.name = name;
       this.products = products;
    }
   
    public Integer getIdSize() {
        return this.idSize;
    }
    
    public void setIdSize(Integer idSize) {
        this.idSize = idSize;
    }
    public Sizetype getSizetype() {
        return this.sizetype;
    }
    
    public void setSizetype(Sizetype sizetype) {
        this.sizetype = sizetype;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Set getProducts() {
        return this.products;
    }
    
    public void setProducts(Set products) {
        this.products = products;
    }




}


