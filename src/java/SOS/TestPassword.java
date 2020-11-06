/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SOS;

import java.io.File;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author Lochana
 */
public class TestPassword {

    public static void main(String[] args) throws NoSuchAlgorithmException {
        try {
            File f = new File("D:\\ABC.jpg");
            System.out.println(f.exists());
            System.out.println("");
            System.out.println(f.toString().getBytes().toString());
            System.out.println(f.toString().getBytes().toString().substring(0,4));
            System.out.println("");
            System.out.println("");
        } catch (Exception e) {
        }
    }

}
