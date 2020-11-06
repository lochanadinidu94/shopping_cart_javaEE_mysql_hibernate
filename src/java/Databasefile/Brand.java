package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Brand generated by hbm2java
 */
public class Brand  implements java.io.Serializable {


     private Integer idBrand;
     private Catagory1 catagory1;
     private Catagory2 catagory2;
     private String name;
     private Set models = new HashSet(0);
     private Set products = new HashSet(0);

    public Brand() {
    }

	
    public Brand(Catagory1 catagory1, Catagory2 catagory2) {
        this.catagory1 = catagory1;
        this.catagory2 = catagory2;
    }
    public Brand(Catagory1 catagory1, Catagory2 catagory2, String name, Set models, Set products) {
       this.catagory1 = catagory1;
       this.catagory2 = catagory2;
       this.name = name;
       this.models = models;
       this.products = products;
    }
   
    public Integer getIdBrand() {
        return this.idBrand;
    }
    
    public void setIdBrand(Integer idBrand) {
        this.idBrand = idBrand;
    }
    public Catagory1 getCatagory1() {
        return this.catagory1;
    }
    
    public void setCatagory1(Catagory1 catagory1) {
        this.catagory1 = catagory1;
    }
    public Catagory2 getCatagory2() {
        return this.catagory2;
    }
    
    public void setCatagory2(Catagory2 catagory2) {
        this.catagory2 = catagory2;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Set getModels() {
        return this.models;
    }
    
    public void setModels(Set models) {
        this.models = models;
    }
    public Set getProducts() {
        return this.products;
    }
    
    public void setProducts(Set products) {
        this.products = products;
    }




}

