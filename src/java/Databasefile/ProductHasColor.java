package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * ProductHasColor generated by hbm2java
 */
public class ProductHasColor  implements java.io.Serializable {


     private Integer id;
     private Color color;
     private Product product;
     private Integer qty;
     private Set wishLists = new HashSet(0);

    public ProductHasColor() {
    }

	
    public ProductHasColor(Color color, Product product) {
        this.color = color;
        this.product = product;
    }
    public ProductHasColor(Color color, Product product, Integer qty, Set wishLists) {
       this.color = color;
       this.product = product;
       this.qty = qty;
       this.wishLists = wishLists;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public Color getColor() {
        return this.color;
    }
    
    public void setColor(Color color) {
        this.color = color;
    }
    public Product getProduct() {
        return this.product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    public Integer getQty() {
        return this.qty;
    }
    
    public void setQty(Integer qty) {
        this.qty = qty;
    }
    public Set getWishLists() {
        return this.wishLists;
    }
    
    public void setWishLists(Set wishLists) {
        this.wishLists = wishLists;
    }




}


