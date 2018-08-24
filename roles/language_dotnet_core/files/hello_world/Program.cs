using System;

namespace hello
{
  class Program
  {
    static void Main(string[] args)
    {
      Console.WriteLine("Hello, World!");

      Console.WriteLine("The sum of 2 and 3 is 5.");

      int sum = Int32.Parse(args[0]) + Int32.Parse(args[1]);

      Console.WriteLine("The sum of {0} and {1} is {2}.",
        args[0], args[1], sum.ToString());
    }
  }
}
