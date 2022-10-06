/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import com.github.britooo.looca.api.core.Looca;
import javax.swing.Timer;
import org.apache.commons.logging.Log;

/**
 *
 * @author ivanm
 */
public class Main {

    public static void main(String[] args) {

        Looca looca = new Looca();

        for (int i = 0; i < 10; i++) {

            System.out.println(looca.getSistema());
        }

    }

}
