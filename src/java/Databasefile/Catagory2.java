package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Catagory2 generated by hbm2java
 */
public class Catagory2  implements java.io.Serializable {


     private Integer idCatagory2;
     private Catagory1 catagory1;
     private String name;
     private Set brands = new HashSet(0);
     private Set models = new HashSet(0);
     private Set products = new HashSet(0);

    public Catagory2() {
    }

	
    public Catagory2(Catagory1 catagory1) {
        this.catagory1 = catagory1;
    }
    public Catagory2(Catagory1 catagory1, String name, Set brands, Set models, Set products) {
       this.catagory1 = catagory1;
       this.name = name;
       this.brands = brands;
       this.models = models;
       this.products = products;
    }
   
    public Integer getIdCatagory2() {
        return this.idCatagory2;
    }
    
    public void setIdCatagory2(Integer idCatagory2) {
        this.idCatagory2 = idCatagory2;
    }
    public Catagory1 getCatagory1() {
        return this.catagory1;
    }
    
    public void setCatagory1(Catagory1 catagory1) {
        this.catagory1 = catagory1;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Set getBrands() {
        return this.brands;
    }
    
    public void setBrands(Set brands) {
        this.brands = brands;
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


