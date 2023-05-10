// Sam 16-bit ISA Simulator
// Neal Nelson, Mar 2023
// Extends to 16 bits and adds Mul, Div instructions to the SamIsaJanSim.java simulator
// This is NOT an object oriented program, rather, a C program in Java.
// Usage:
//   - java Sam16sim samprog.sam (and reads from samprog.sam.codlst).

// Todo:
//   - Add try-catch exceptions for file open, parseIint, nextInt
//   - The simulator displays the contents of memory, but no longer the
//       original contents of memory. That's probably ok.
//   - Upgrade to display the acc, out and only the dat memory, and a window around the pc.


import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

class samsim {
  // SAM ISA machine state  (global)
  static int MEMSIZE = 4096;  // 2^12  = 16^3
  static int acc = 0;
  static int pc = 0;
  static int out = 0;

  static int codeLen;
  static int mem[] = new int[MEMSIZE];
  static String asm[] = new String[MEMSIZE];

public static void main(String args[]) throws FileNotFoundException {

  if (args.length < 1) {
   System.out.println("Usage: java Sam16sim codeFile");
   System.exit(-1);
  } 

  // Set up Sam console read
  Scanner scan = new Scanner(System.in);

  // Open hex code file and asm listing file (combine these later)

  // Try and catch FileNotFoundException and System.exit(-1);
  //System.out.println("Reading code from SAM hexfile " + args[0]);
  //File hexcode = new File(args[0]);;
  //Scanner filescan = new Scanner(hexcode);

  // Try and Catch InputMismatchException
  System.out.println("Reading SAM assembly code and listing file " + args[0] + ".codlst");
  File asmcode = new File(args[0] + ".codlst");
  Scanner asmscan = new Scanner(asmcode);


  // Initialize the Sam machine state (registers and memory)
  //initSamState(filescan, asmscan);
  initSamState(asmscan);
  
  // Print the initial SAM machine state
  display();

  // Sam ISA simulation loop
  System.out.print("Enter cmd (run, step or quit):");
  char cmd = scan.next().charAt(0);
  while ((cmd != 'r') && (cmd != 's') && (cmd != 'q')) {
    System.out.print("Enter cmd (run, step or quit):");
    cmd = scan.next().charAt(0);
  }
  while (cmd != 'q') {

    //Debug
    //System.out.println("mem[pc] " + mem[pc]);

    // Decode the instruction at Pc
    int opcode = mem[pc]/4096;
    int addr = mem[pc] % 4096;

    // Perform the instruction and display machine state
    step(scan, opcode, addr);

    // if cmd == 'r' and opcode != 15 (hlt) we do not display the state
    if (cmd == 'r' && opcode == 15) {
      //display();
      return;
    }

    if (cmd == 's') {
      display();
      scan.nextLine();  // eat up newline
      System.out.print("Enter cmd (run, step or quit):");
      cmd = scan.next().charAt(0);
    }
  }

}

// Sam Instruction Decode and Execution
public static void step(Scanner scan, int opcode, int addr) {
  //Debug
  //System.out.println("opcode " + opcode);
  //System.out.println("addr " + addr);
  if (opcode == 0) {				// Lda
    pc++; acc = mem[addr];
  }
  else if (opcode == 1) {			// Add
    pc++; acc = (acc + mem[addr]) & 0xffff;
  }
  else if (opcode == 2) { 			// Sub
    pc++; acc = (acc - mem[addr]) & 0xffff;
  }
  else if (opcode == 3) {			// Sta
    pc++; mem[addr] = acc;
  }
  else if (opcode == 4) {			// Jmp
    pc = addr;
  }
  else if (opcode == 5) {			// Jaz
    if (acc == 0) pc = addr; else pc++;
  }
  else if (opcode == 6) {			// Jan
    if (acc >= 128) pc = addr; else pc++;
  }
  else if (opcode == 7) {			// Mul
    pc++; acc = (acc * mem[addr]) & 0xffff;
  }
  else if (opcode == 8) {			// Div
    pc++; acc = (acc / mem[addr]) & 0xffff;
  }
  else if (opcode == 9) {			// Rem
    pc++; acc = (acc % mem[addr]) & 0xffff;
  }
  else if (opcode == 13) {			// In
    pc++;					// (pauses execution until input)
    System.out.print("In : ");
    // try and catch NumberFormatException here and System.exit(-1)
    acc = Integer.parseInt(scan.next());
  }
  else if (opcode == 14) {			// Out
    pc++; out = acc;
    System.out.println("Out: " + out);
  }
  else if (opcode == 15) {			// Hlt
    System.out.println(String.format("Hlt   "));
  }
  else { System.out.println("Illegal Instruction at pc = " + pc);
    System.exit(-1);
  }

}

// Sam machine state display
public static void display() {
  System.out.println("SAM machine state");
  System.out.println(String.format("Pc: %03x  Acc: %04x  Out: %04x",pc,acc,out));

  String pad    = "  ";
  String pcmark = "> ";
  for (int i = 0; i < codeLen; i++) {
    if (i == pc) pad = "> "; else pad = "  ";
    System.out.print(String.format(pad + "%03x %04x",i,mem[i]));
    System.out.print("\t" + asm[i]); // assembly code asm[] read in from *.lst
    System.out.println(); 
  }
}

// Read in Sam hex code and assembly listing. They need to be the same length.
// Maybe I should just read them from the same file? Yes, todo. Avoids duplication.

//public static void initSamState(Scanner filescan, Scanner asmscan) {
public static void initSamState(Scanner asmscan) {
  int i;

  // Initialize pc and acc
  pc = 0; acc = 0;

  // Read in hex code and assembly listing from files (combine these later)

//  filescan.useRadix(16);
//  for (i = 0; i < MEMSIZE && filescan.hasNext(); i++) {
    // Try and Catch InputMismatchException
//    mem[i] = filescan.nextInt() & 0xffff; // memory is 16 bits
//    filescan.nextLine();                // skip over all else as comments
//  }
//  codeLen = i;

  asmscan.useRadix(16);
  for (i = 0; i < MEMSIZE && asmscan.hasNext(); i++) {
    mem[i] = asmscan.nextInt() & 0xffff;
    asm[i] = asmscan.nextLine();
  }
  codeLen = i;

//  if (codeLen != i) {
//    System.out.println("Code and listing file length differ");
//    System.exit(-1);
//  }
  
}

}
