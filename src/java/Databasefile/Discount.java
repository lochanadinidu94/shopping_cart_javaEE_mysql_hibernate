package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1



/**
 * Discount generated by hbm2java
 */
public class Discount  implements java.io.Serializable {


     private Integer idDiscount;
     private Distype distype;
     private Product product;
     private Double discount;

    public Discount() {
    }

	
    public Discount(Distype distype, Product product) {
        this.distype = distype;
        this.product = product;
    }
    public Discount(Distype distype, Product product, Double discount) {
       this.distype = distype;
       this.product = product;
       this.discount = discount;
    }
   
    public Integer getIdDiscount() {
        return this.idDiscount;
    }
    
    public void setIdDiscount(Integer idDiscount) {
        this.idDiscount = idDiscount;
    }
    public Distype getDistype() {
        return this.distype;
    }
    
    public void setDistype(Distype distype) {
        this.distype = distype;
    }
    public Product getProduct() {
        return this.product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    public Double getDiscount() {
        return this.discount;
    }
    
    public void setDiscount(Double discount) {
        this.discount = discount;
    }




}


