import java.io.*;
import java_cup.runtime.*;

public class LexerTest {

    public static void main(String[] argv) {
        Symbol sym;
        final String format = "%-7s %2s, %-8s %-10s\n";

        System.out.format(
                    format,
                    "TYPE", "LN", "COL", "VALUE"
                );

        try {
            Lexer lexer = new Lexer(new FileReader(argv[0]));
            for (sym = lexer.next_token(); sym.sym != 0; sym = lexer.next_token()) {

                System.out.format(
                    format,
                    sym, sym.left+1, sym.right, sym.value
                );

            }
        } catch (Exception e) {
        }
    }
}
