/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Class;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Lochana
 */
public class SessionCart {

    private List<SessionCartItems> old_ciems;

    public SessionCart() {
        old_ciems = new ArrayList<SessionCartItems>();
    }

    /**
     * @return the old_ciems
     */
    public List<SessionCartItems> getOld_ciems() {
        return old_ciems;
    }

    public void addProduct(SessionCartItems new_items) {
        for (int i = 0; i < old_ciems.size(); i++) {

            SessionCartItems ci = old_ciems.get(i);

            int Qty = 0;

            if (ci.getPid() == new_items.getPid() && ci.getColor().equals(new_items.getColor())) {
                Qty = ci.getQty() + new_items.getQty();
                old_ciems.remove(ci);
                new_items.setQty(Qty);
            }

        }
        old_ciems.add(new_items);
    }

    public void removeSessionCartItems(SessionCartItems crt) {
        for (int i = 0; i < old_ciems.size(); i++) {
            SessionCartItems scrt = old_ciems.get(i);

            if (scrt.getPid() == crt.getPid() && scrt.getColor().equals(crt.getColor())) {
                old_ciems.remove(scrt);
            }

        }
    }

}
