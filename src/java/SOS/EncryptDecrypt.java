/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package SOS;



import com.sun.jersey.core.util.Base64;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.swing.JOptionPane;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 *
 * @author Rohan
 */
public class EncryptDecrypt {
public String encrypttwo(String password) {
    Base64 codec = new Base64();
    byte[] temp;
    String encodedPassword = null;
    temp = codec.encode(password.getBytes());
    encodedPassword = new String(temp);
    return encodedPassword;
}

//Decrypt method
public String decrypttwo(String encodedPassword) {
    Base64 codec = new Base64();    
    byte[] temp;
    String decodedPassword;
    temp = codec.decode(encodedPassword.getBytes());
    decodedPassword = new String(temp);
    return decodedPassword;
}
    
    
    
    public String Encrypt(String decript) throws NoSuchAlgorithmException{
        
            Cipher cipher;
            // Input encrypted String
            String input = decript;
            // password for encryption
            String strPassword = "password12345678";
            // put this as key in AES
            SecretKeySpec key = new SecretKeySpec(strPassword.getBytes(), "AES");
            
            
            
            // Parameter specific algorithm
            AlgorithmParameterSpec paramSpec = new   IvParameterSpec(strPassword.getBytes());
            //Whatever you want to encrypt/decrypt
            //Cipher cipher;
            try{
            cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            
            
            // You can use ENCRYPT_MODE (ENCRYPTunderscoreMODE)  or DECRYPT_MODE (DECRYPT underscore MODE)
            cipher.init(Cipher.ENCRYPT_MODE, key, paramSpec);
            
            // encrypt data
            byte[] ecrypted;
            
            ecrypted = cipher.doFinal(input.getBytes());
            String output =  new BASE64Encoder().encode(ecrypted);
                System.out.println(output);
            return output;
    }catch(Exception e){
                e.printStackTrace();
    }
            
            // encode data using standard encoder
            
            
           // System.out.println("Orginal tring: " + input);
            // System.out.println("Encripted string: " + output);
            
            
            return null;
  }
    
    public String Decrypt(String encript){
         
      Cipher cipher;   
    // Input encrypted String  
    String input = encript;  
   // password to decrypt 16 bit  
    String strPassword = "password12345678";  
   // put this as key in AES  
   SecretKeySpec key = new SecretKeySpec(strPassword.getBytes(), "AES");  
     try{
    AlgorithmParameterSpec paramSpec = new IvParameterSpec(strPassword.getBytes());   
    //Whatever you want to encrypt/decrypt using AES /CBC padding  
    cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");  
  
    //You can use ENCRYPT_MODE or DECRYPT_MODE   
     cipher.init(Cipher.DECRYPT_MODE, key, paramSpec);    
  
     //decode data using standard decoder  
     byte[] output =  new BASE64Decoder().decodeBuffer(input);    
  
       // Decrypt the data   
     byte[] decrypted = cipher.doFinal(output);  
  
     System.out.println("Original string: " +  
             new String(input));  
  
     // decryptedData .;  
     System.out.println("Decrypted string: " +  
     new String(decrypted));
     return new String(decrypted);
     }catch(Exception e){
     
     JOptionPane.showMessageDialog(null, e);
     }
      return null;
  
  }
    
}
