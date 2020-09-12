import java.io.*;
import java_cup.runtime.*;

public class LexerTest {

    public static void main(String[] argv) {
        Symbol sym;
        try {
            Lexer lexer = new Lexer(new FileReader(args[0]));
            for (sym = lexer.next_token(); sym.sym != 0; sym = lexer.next_token()) {

                System.out.println( 
                    "Token " +      sym +
                    "\t" +          sym.value + 
                    "\t(" +         sym.left +
                    ", " +          sym.right +
                    ")"
                );

            }
        } catch (Exception e) {
        }
    }
}
