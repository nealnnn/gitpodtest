// Sam16 ISA Assembler
// Neal Nelson, Mar 2023
// New instructions for Mul, Div
// This is NOT an object oriented program, rather, a C program in Java.

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.Scanner;

class samasm {
  static final int MEMSIZE = 4096;
  static final int OPTABSIZE = 16;
  static int codeLen = 0;

  // It would be a little nicer to use a "codeline" object with three fields
  static String[] lab = new String[MEMSIZE];
  static String[] op = new String[MEMSIZE];
  static String[] addr = new String[MEMSIZE];

  // This could be a dictionary
  static int[] code = new int[MEMSIZE];
  static String[] opTab = {"lda", "add", "sub", "sta", "jmp", "jaz", "jan", "mul",
                           "div", "rem", "", "", "", "in", "out", "hlt"};

public static void main(String args[]) throws FileNotFoundException {

  if (args.length < 1) {
    System.out.println("Usage; java SamAsm asmfile.txt");
  }
  else {
    // Code File output
    File outCodeFile = new File(args[0] + ".cod");
    PrintStream outcode = new PrintStream(outCodeFile);

    // Listing File output
    File outListFile = new File(args[0] + ".codlst");
    PrintStream outlist = new PrintStream(outListFile);

    // Assembly File input
    File asmcode = new File(args[0]);
    Scanner filescan = new Scanner(asmcode);
    filescan.useRadix(16);

    // The assembler
    parse(filescan);
    genCode();
    showAsmCode();
    dumpCode(outcode);
    dumpListing(outlist);
      
  }

}

// Read Sam Asm code and produce [ (String lab, String op, String addr) ]
// Three parallel arrays: lab[MEMSIZE], op[MEMSIZE], addrMEMSIZE[]
// Pass 1 - Fill in the parallel arrays with strings. Labels end with : (colon)

public static void parse(Scanner filescan) {
  String codeStr;
  String[] codeline;
  int codeIndex = 0;
  while ( filescan.hasNext() ) {
    if ( codeIndex >= MEMSIZE ) {
      System.out.println("Program is too big for SAM memory - abort");
      System.exit(-1);
    }

    codeStr = filescan.nextLine();

    //Debug
    //System.out.print(codeStr + "  ");

    // This codestr could be 0, 1, 2, or 3 tokens. Ignore 4 and after.
    // 0 is a blank line. Go on, ignoring this line.
    // 1 is a label by itself, ignoring this line.
    // 2 is a label (possibly "")  and an operator.
    // 3 is a label (possibly ""), an operator, and an address.

    // Note that this split does not remove leading or trailing whitespace.
    // Therefore, entries in the codeline array could be empty strings at the beginning
    //   (but not the end, interestingly)
    // Note that this method requires a label to be in column 1 and also
    //   rejects an operator in the first column.
    // Use .trim(). before split to remove leading and trailing whitespace
    codeline = codeStr.split("\\s+");   // greedy split on whitespace

    // Debug
    //for (String codepart: codeline) { System.out.print(codepart + "\t"); }
    //System.out.print("\t     " + codeline.length);
    //System.out.println();

    if (codeline.length == 0) {
      System.out.println("Blank line; ignore");
      continue;					// skip blank lines
    }
    if (codeline.length == 1) {
      System.out.println("Lone label; ignore");
      continue;					// skip lone labels
    }

    lab[codeIndex] = codeline[0];
    op[codeIndex] = codeline[1];

    if ( codeline.length == 2 ) { 
      addr[codeIndex] = "";
    }
    else {
      addr[codeIndex] = codeline[2];
    }
    codeIndex++; 
  }
  codeLen = codeIndex;   // A little redundant here, could just use one variable. 
}

public static void showAsmCode() {
  System.out.println("\nCode Length: " + codeLen);
  for (int i = 0; i < MEMSIZE && i < codeLen; i++) {
    System.out.println(lab[i] + "\t" + op[i] + "\t"
                    + addr[i] + "  \t"
                    + String.format("%03x",i) + "  "
                    + String.format("%04x",(code[i] & 0xffff )));
  }
}

public static void dumpCode(PrintStream outcode) {
  for (int i = 0; i < codeLen; i++) {
    outcode.println(String.format("%04x",(code[i] & 0xffff )));
  }
}

public static void dumpListing(PrintStream outlist) {
  for (int i = 0; i < codeLen; i++) {
    outlist.println(String.format("%04x",(code[i] & 0xffff )) + "\t"
                  + String.format("%03x",i) + "\t"
                  + lab[i] + "\t" + op[i] + "\t" + addr[i] );
  }
}

public static int getOpNum(String opStr) {
  int i;
  for (i = 0; i < OPTABSIZE; i++ ) {
    if ( opStr.toLowerCase().equals(opTab[i]) ) return i;
  }
  return -1;
}

// Bug: If you call getLabNum with empty string you get the first empty label!
public static int getLabNum(String labStr) {
  int i;
  if (labStr.equals("") ) return 0;	// For out and hlt where addr is ""
  for (i = 0; i < codeLen; i++ ) {
    if ( labStr.equals(lab[i]) ) return i;
  }
  return -1;
}

// Fill in the code table with instructions at the beginning of memory
public static void genCode() {
  int theOp, theAddr;
  int i;
  for ( i = 0; i < codeLen && !op[i].toLowerCase().equals("dat"); i++ ) {
    if (getOpNum(op[i]) < 0) {
      System.out.println("Unknown instruction " + op[i] + " - aborting");
      return;
    }

    if (getLabNum(addr[i]) < 0) {
      System.out.println("Missing label in Column 1: " + addr[i] + " - aborting");
      return;
    }
    // Debug
    //System.out.println("op[i]: " + op[i] + "  " + getOpNum(op[i]));
    //System.out.println("addr[i]: " + addr[i] + "  " + getLabNum(addr[i]) );

    code[i] = (getOpNum(op[i])) * 4096 + getLabNum(addr[i]);
    // Debug
    // System.out.println(i + "  " + String.format("%04x",(code[i] & 0xffff ))); 
             // Debug + "     " + getOpNum(op[i]) + "  "
             // Debug           + getLabNum(addr[i]));
  }
  // Debug
  //System.out.println("index i: " + i);
  //System.out.println("codeLen: " + codeLen);

  // Now gen data
  for ( ; i < codeLen; i++ ) {
    if ( !op[i].toLowerCase().equals("dat") ) {
      System.out.println("Data only section " + op[i] + " - aborting");
      return;
    }
    code[i] = Integer.parseInt(addr[i], 16);
    // Debug
    //System.out.println(String.format("%03x", i) + "  " 
    //                 + String.format("%04x",(code[i] & 0xffff )));
  }

}

}
