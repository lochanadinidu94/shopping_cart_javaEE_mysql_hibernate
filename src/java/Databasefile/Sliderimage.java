package Databasefile;
// Generated Jan 7, 2016 12:21:02 PM by Hibernate Tools 4.3.1



/**
 * Sliderimage generated by hbm2java
 */
public class Sliderimage  implements java.io.Serializable {


     private Integer idSliderImage;
     private String image;

    public Sliderimage() {
    }

    public Sliderimage(String image) {
       this.image = image;
    }
   
    public Integer getIdSliderImage() {
        return this.idSliderImage;
    }
    
    public void setIdSliderImage(Integer idSliderImage) {
        this.idSliderImage = idSliderImage;
    }
    public String getImage() {
        return this.image;
    }
    
    public void setImage(String image) {
        this.image = image;
    }




}


