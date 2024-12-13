import 'dart:io';
import 'package:vania/vania.dart';
import 'create_users_table.dart';
import 'customers.dart';
import 'orders.dart';
import 'orderitems.dart';
import 'products.dart';
import 'productnotes.dart';
import 'vendors.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		 await CreateUserTable().up();
		 await Customers().up();
		 await Orders().up();
		 await Orderitems().up();
		 await Products().up();
		 await Productnotes().up();
		 await Vendors().up();
	}

  dropTables() async {
		 await Vendors().down();
		 await Productnotes().down();
		 await Products().down();
		 await Orderitems().down();
		 await Orders().down();
		 await Customers().down();
		 await CreateUserTable().down();
	 }
}
