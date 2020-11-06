/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Class;

import Databasefile.Addreg;
import Databasefile.HibernateConnection;
import Databasefile.Msg;
import Databasefile.WishList;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Lochana pakaya
 */
public class AutoControl {

    Session ses = new HibernateConnection().getSessionFactory().openSession();
    Databasefile.Msg ma = new Msg();
    Transaction tr = ses.beginTransaction();

    public AutoControl() {
        removeWishlistExp();
        removeAddExp();
        tr.commit();
        ses.close();
    }

    public Date dateRoll(int i) {
        GregorianCalendar g = new GregorianCalendar();
        g.setTime(new Date());
        g.add(Calendar.DATE, i);
        return g.getTime();
    }

    public void removeWishlistExp() {

        try {
            Criteria cr = ses.createCriteria(Databasefile.WishList.class);
            List<Databasefile.WishList> li = cr.list();
            for (WishList li1 : li) {
                if (li1.getExpDate().before(new Date())) {
                    String Email = li1.getUser().getEmail();
                    String i = "Hi.. " + li1.getUser().getFistName() + " Your " + li1.getProduct().getName() + "/" + li1.getProduct().getDiscription() + " item is auto remove in your wish list.Thank you";

                    ma.setDate(new Date());
                    ma.setMsg(i);
                    ma.setUser(li1.getUser());
                    ses.save(ma);

                    ses.delete(li1);

                    try {
                        EmailHtml.htmlcontent(Email, "drpcsoftwaresolution@gmail.com", "dinidu066", "<h3>" + i + "</h3><img src='http://ritarsoft.com/images/images/Logo-e-commerce-english.JPG' width='300px' height='100px'/>", "Notification - (E-Market (pvt) ltd.)");
                    } catch (Exception e) {
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void removeAddExp() {

        try {
            Criteria cr = ses.createCriteria(Databasefile.Addreg.class);
            List<Databasefile.Addreg> li = cr.list();
            for (Addreg li1 : li) {
                if (li1.getExpdate().before(new Date())) {
                    if (li1.getStates().equals("De-Active")) {
                        System.out.println("d d d d d d d dd  d dd d d d d d d d d d d d d d d d  d d d d d d d d d d d d ");
                    } else {
                        String Email = li1.getUser().getEmail();
                        String i = "Hi.. " + li1.getUser().getFistName() + " Your " + li1.getReason() + " Advertisement is auto De-Active in site.Thank you";

                        ma.setDate(new Date());
                        ma.setMsg(i);
                        ma.setUser(li1.getUser());
                        ses.save(ma);

                        li1.setStates("De-Active");
                        ses.update(li1);

                        try {
                            EmailHtml.htmlcontent(Email, "drpcsoftwaresolution@gmail.com", "dinidu066", "<h3>" + i + "</h3><img src='http://ritarsoft.com/images/images/Logo-e-commerce-english.JPG' width='300px' height='100px'/>", "Notification - (E-Market (pvt) ltd.)");
                        } catch (Exception e) {
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
