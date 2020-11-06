/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Class;

/**
 *
 * @author Lochana
 */
public class TestSMS {

    public static void main(String[] args) {

        try {
            java.lang.String toNumber = "0711043828";
            java.lang.String fromName = "dsd";
            java.lang.String messageText = "sds";
            java.lang.String optionalTextFormat = "";
            com.strikeiron.GlobalSMSPro service = new com.strikeiron.GlobalSMSPro();
            com.strikeiron.GlobalSMSProSoap port = service.getGlobalSMSProSoap();
            // TODO process result here
            com.strikeiron.SIWsOutputOfTextMessagingResult result = port.sendMessage(toNumber, fromName, messageText, optionalTextFormat);
            System.out.println("Result = " + result);
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

}
