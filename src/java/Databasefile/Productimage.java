package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1



/**
 * Productimage generated by hbm2java
 */
public class Productimage  implements java.io.Serializable {


     private Integer idProductImage;
     private Product product;
     private String url1;
     private String url2;
     private String url3;
     private String url4;

    public Productimage() {
    }

	
    public Productimage(Product product) {
        this.product = product;
    }
    public Productimage(Product product, String url1, String url2, String url3, String url4) {
       this.product = product;
       this.url1 = url1;
       this.url2 = url2;
       this.url3 = url3;
       this.url4 = url4;
    }
   
    public Integer getIdProductImage() {
        return this.idProductImage;
    }
    
    public void setIdProductImage(Integer idProductImage) {
        this.idProductImage = idProductImage;
    }
    public Product getProduct() {
        return this.product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    public String getUrl1() {
        return this.url1;
    }
    
    public void setUrl1(String url1) {
        this.url1 = url1;
    }
    public String getUrl2() {
        return this.url2;
    }
    
    public void setUrl2(String url2) {
        this.url2 = url2;
    }
    public String getUrl3() {
        return this.url3;
    }
    
    public void setUrl3(String url3) {
        this.url3 = url3;
    }
    public String getUrl4() {
        return this.url4;
    }
    
    public void setUrl4(String url4) {
        this.url4 = url4;
    }




}


