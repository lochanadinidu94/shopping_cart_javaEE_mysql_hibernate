package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1



/**
 * Ratting generated by hbm2java
 */
public class Ratting  implements java.io.Serializable {


     private Integer idRatting;
     private Invoiceinformation invoiceinformation;
     private Product product;
     private String states;

    public Ratting() {
    }

	
    public Ratting(Invoiceinformation invoiceinformation, Product product) {
        this.invoiceinformation = invoiceinformation;
        this.product = product;
    }
    public Ratting(Invoiceinformation invoiceinformation, Product product, String states) {
       this.invoiceinformation = invoiceinformation;
       this.product = product;
       this.states = states;
    }
   
    public Integer getIdRatting() {
        return this.idRatting;
    }
    
    public void setIdRatting(Integer idRatting) {
        this.idRatting = idRatting;
    }
    public Invoiceinformation getInvoiceinformation() {
        return this.invoiceinformation;
    }
    
    public void setInvoiceinformation(Invoiceinformation invoiceinformation) {
        this.invoiceinformation = invoiceinformation;
    }
    public Product getProduct() {
        return this.product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    public String getStates() {
        return this.states;
    }
    
    public void setStates(String states) {
        this.states = states;
    }




}


