public class EchoArgs
{ public static void main(String[] args)
  { System.out.println("Number of command line args: " + args.length);
    for (int i = 0; i < args.length; i++) {
      System.out.println(i + " " + args[i]); 
    }
  }
}
