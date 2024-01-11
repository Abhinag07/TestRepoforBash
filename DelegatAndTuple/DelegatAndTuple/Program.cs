using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DelegatAndTuple
{
	public delegate bool promotioneligible(Employee employee);
	public class Program
	{
		
		static void Main(string[] args)
		{

			List<Employee> list = new List<Employee>();	
			Employee enp1 = new Employee() { Id = 1, Name="John", Experience=6,salary=464 };
			Employee enp2 = new Employee() { Id = 2, Name = "Ron", Experience = 16, salary = 3464 };
			Employee enp3 = new Employee() { Id = 3, Name = "Don", Experience = 3, salary = 46334 };

			list.Add(enp1);
			list.Add(enp2);
			list.Add(enp3);

			Program program = new Program();
			promotioneligible promotioneligible = new promotioneligible(program.Promote);
			Console.WriteLine("Promoted are  ");
			foreach(Employee emp in list)
			{
				if(promotioneligible(emp))
					Console.WriteLine(emp.Name);
			}
			Console.ReadLine();
		}

		public bool Promote(Employee employee)
		{
			if (employee.Experience > 5)
			{
				return true;

			}
			else
				return false;
		}
	}
}



/*
 public void method1() {

			Console.WriteLine("IN method1");
		}

		public void method2()
		{

			Console.WriteLine("IN method2");
		}
		public void method3()
		{

			Console.WriteLine("IN method3");
		}
 */