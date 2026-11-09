import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AtyabAlFakhamaApp());
}

class AtyabAlFakhamaApp extends StatelessWidget {
  const AtyabAlFakhamaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أطياب الفخامة - Atyab Al Fakhama',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF9F6F0),
        fontFamily: 'Cairo',
      ),
      home: const SplashScreen(),
    );
  }
}

// 1. شاشة البداية
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD4AF37), width: 2),
                color: Colors.white,
              ),
              child: const Center(
                child: Text('A', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, fontFamily: 'serif')),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'أطياب الفخامة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const Text(
              'P E R F U M E',
              style: TextStyle(
                color: Color(0xFFD4AF37),
                fontSize: 14,
                letterSpacing: 4.0,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              color: Color(0xFFD4AF37),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. شاشة تسجيل الدخول واختيار الفرع
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedBranch;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<String> branches = [
    'فرع شاوة الرئيسي (المنصورة)',
    'فرع المحل الثاني',
    'الفرع المركزي / الإدارة'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('تسجيل الدخول - نظام أطياب الفخامة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'اختر الفرع ونظام التشغيل',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'الفرع التشغيلي',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: selectedBranch,
                  items: branches.map((String branch) {
                    return DropdownMenuItem<String>(
                      value: branch,
                      child: Text(branch),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBranch = newValue;
                    });
                  },
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'اسم المستخدم أو الكود',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      if (selectedBranch == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('الرجاء اختيار الفرع أولاً')),
                        );
                        return;
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MainHomeScreen()),
                      );
                    },
                    child: const Text(
                      'دخول للنظام (يعمل بدون انترنت)',
                      style: TextStyle(fontSize: 16, color: Color(0xFFD4AF37), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 3. الشاشة الرئيسية للتنقل بين الأقسام
class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const PosScreen(),
    const InventoryScreen(),
    const PurchasesAndExpensesScreen(),
    const ReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.brown.shade900,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.point_of_sale), label: 'نقطة البيع'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'المخزون'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'المشتريات والمصروفات'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'التقارير المالية'),
        ],
      ),
    );
  }
}

// 4. نقطة البيع (POS) مع خانة الخصم
class CartItem {
  final String productId;
  final String productName;
  final double price;
  int quantity;
  final String unit;

  CartItem({required this.productId, required this.productName, required this.price, required this.quantity, required this.unit});
}

class PosScreen extends StatefulWidget {
  const PosScreen({Key? key}) : super(key: key);

  @override
  _PosScreenState createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  List<CartItem> cart = [];
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  double discountAmount = 0.0;

  final List<Map<String, dynamic>> availableProducts = [
    {'id': '1', 'name': 'أرماندو جولد (50مل)', 'price': 250.0, 'stock': 4, 'unit': 'قطعة'},
    {'id': '2', 'name': 'مس بيري (ميكس خاص)', 'price': 220.0, 'stock': 12, 'unit': 'قطعة'},
    {'id': '3', 'name': 'كريزي فانيلا', 'price': 200.0, 'stock': 8, 'unit': 'قطعة'},
    {'id': '4', 'name': 'مسك أبيض شفاف (بالجرام)', 'price': 5.0, 'stock': 500, 'unit': 'جرام'},
  ];

  double get totalAmount => cart.fold(0, (sum, item) => sum + (item.price * item.quantity));
  
  double get netTotal {
    double net = totalAmount - discountAmount;
    return net < 0 ? 0 : net;
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      int index = cart.indexWhere((item) => item.productId == product['id']);
      if (index >= 0) {
        cart[index].quantity++;
      } else {
        cart.add(CartItem(
          productId: product['id'],
          productName: product['name'],
          price: product['price'],
          quantity: 1,
          unit: product['unit'],
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('نقطة البيع - أطياب الفخامة (POS)', style: TextStyle(color: Color(0xFFD4AF37))),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ابحث عن العطر أو المنتج...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: availableProducts.length,
                    itemBuilder: (context, index) {
                      final prod = availableProducts[index];
                      return InkWell(
                        onTap: () => addToCart(prod),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(prod['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2),
                                const SizedBox(height: 5),
                                Text('${prod['price']} ج.م', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                Text('المتاح: ${prod['stock']} ${prod['unit']}', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    color: Colors.brown.shade50,
                    child: const Text('فواتير المبيعات الحالية', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.brown)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: customerNameController,
                          decoration: const InputDecoration(labelText: 'اسم العميل (اختياري)', isDense: true),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: customerPhoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(labelText: 'رقم الهاتف (اختياري)', isDense: true),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        return ListTile(
                          title: Text(item.productName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          subtitle: Text('${item.price} ج.م × ${item.quantity}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, size: 20, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    if (item.quantity > 1) {
                                      item.quantity--;
                                    } else {
                                      cart.removeAt(index);
                                    }
                                  });
                                },
                              ),
                              Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline, size: 20, color: Colors.green),
                                onPressed: () {
                                  setState(() {
                                    item.quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('الإجمالي الفرعي:', style: TextStyle(fontSize: 14)),
                            Text('$totalAmount ج.م', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: discountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'قيمة الخصم (ج.م)',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) {
                            setState(() {
                              discountAmount = double.tryParse(val) ?? 0.0;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('الإجمالي النهائي:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown)),
                            Text('$netTotal ج.م', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                            onPressed: cart.isEmpty ? null : () => _showCheckoutDialog(context),
                            child: const Text('إتمام الدفع وتسجيل الفاتورة', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    String selectedPaymentMethod = 'نقدي (كاش)';
    List<String> paymentMethods = ['نقدي (كاش)', 'إنستاباي (InstaPay)', 'فودافون كاش', 'آجل / على الحساب'];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('اختر وسيلة الدفع'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: paymentMethods.map((method) {
                  return RadioListTile<String>(
                    title: Text(method),
                    value: method,
                    groupValue: selectedPaymentMethod,
                    onChanged: (val) {
                      setDialogState(() {
                        selectedPaymentMethod = val!;
                      });
                    },
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('إلغاء'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      cart.clear();
                      customerNameController.clear();
                      customerPhoneController.clear();
                      discountController.clear();
                      discountAmount = 0.0;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تمت عملية البيع بنجاح عبر ($selectedPaymentMethod)!')),
                    );
                  },
                  child: const Text('تأكيد وطباعة الفاتورة', style: TextStyle(color: Color(0xFFD4AF37))),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// 5. إدارة المخزون (14 خانة والتنبيهات)
class ProductModel {
  String id;
  String category;
  String name;
  String sizeOrWeight;
  double quantity;
  String unit;
  double costPrice;
  double wholesalePrice;
  double retailPrice;
  double profitMargin;
  double lowStockAlertLimit;
  String notes;
  String imageOrColor;

  ProductModel({
    required this.id,
    required this.category,
    required this.name,
    required this.sizeOrWeight,
    required this.quantity,
    required this.unit,
    required this.costPrice,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.lowStockAlertLimit,
    required this.notes,
    required this.imageOrColor,
  }) : profitMargin = costPrice > 0 ? ((retailPrice - costPrice) / costPrice) * 100 : 0;
}

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<ProductModel> products = [
    ProductModel(
      id: '1',
      category: 'عطور',
      name: 'أرماندو جولد (Armando Gold)',
      sizeOrWeight: '50 مل',
      quantity: 4.0,
      unit: 'قطعة',
      costPrice: 120.0,
      wholesalePrice: 200.0,
      retailPrice: 250.0,
      lowStockAlertLimit: 5.0,
      notes: 'عطر فاخر مميز',
      imageOrColor: 'gold',
    ),
    ProductModel(
      id: '2',
      category: 'كحول',
      name: 'كحول إيثيلي عالي الجودة',
      sizeOrWeight: '1 لتر',
      quantity: 25.0,
      unit: 'لتر',
      costPrice: 60.0,
      wholesalePrice: 80.0,
      retailPrice: 100.0,
      lowStockAlertLimit: 10.0,
      notes: 'لتركيبات العطور',
      imageOrColor: 'clear',
    ),
  ];

  final List<String> categories = [
    'عطور', 'معطرات', 'بخور', 'مباخر', 'منظفات', 
    'مستحضرات تجميل', 'اكسسوارات', 'كحول', 'زجاج', 'أخرى'
  ];

  final List<String> units = ['جرام', 'لتر', 'قطعة', 'دسته', 'كرتونة'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('إدارة مخزون أطياب الفخامة', style: TextStyle(color: Color(0xFFD4AF37))),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          bool isLowStock = product.quantity <= product.lowStockAlertLimit;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isLowStock ? Colors.red : Colors.brown.shade200,
                width: isLowStock ? 2 : 1,
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.brown.shade100,
                child: const Icon(Icons.store, color: Colors.brown),
              ),
              title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(
                'الفئة: ${product.category} | الحجم: ${product.sizeOrWeight}\nالكمية المتاحة: ${product.quantity} ${product.unit}',
                style: TextStyle(color: isLowStock ? Colors.red.shade700 : Colors.black87),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${product.retailPrice} ج.م', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  Text('ربح: ${product.profitMargin.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  if (isLowStock)
                    const Text('⚠️ منخفض', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Color(0xFFD4AF37)),
        onPressed: () {
          _showAddProductDialog(context);
        },
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    String? selectedCategory;
    String selectedUnit = 'قطعة';
    final TextEditingController nameController = TextEditingController();
    final TextEditingController sizeController = TextEditingController();
    final TextEditingController qtyController = TextEditingController();
    final TextEditingController costController = TextEditingController();
    final TextEditingController wholesaleController = TextEditingController();
    final TextEditingController retailController = TextEditingController();
    final TextEditingController alertLimitController = TextEditingController();
    final TextEditingController notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('إضافة منتج جديد للمخزن'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: '1. الفئة'),
                  items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                  onChanged: (val) => selectedCategory = val,
                ),
                TextField(controller: nameController, decoration: const InputDecoration(labelText: '2. اسم المنتج')),
                TextField(controller: sizeController, decoration: const InputDecoration(labelText: '3. الحجم أو الوزن (مثل: 50مل)')),
                TextField(controller: qtyController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: '4. الكمية الأولية')),
                DropdownButtonFormField<String>(
                  value: selectedUnit,
                  decoration: const InputDecoration(labelText: '5. وحدة القياس'),
                  items: units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                  onChanged: (val) => selectedUnit = val!,
                ),
                TextField(controller: costController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: '6. سعر التكلفة')),
                TextField(controller: wholesaleController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: '7. سعر البيع - جملة')),
                TextField(controller: retailController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: '8. سعر البيع - قطاعي')),
                TextField(controller: notesController, decoration: const InputDecoration(labelText: '12. ملاحظات')),
                TextField(controller: alertLimitController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: '14. حد التنبيه بانخفاض المخزون')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('حفظ المنتج', style: TextStyle(color: Color(0xFFD4AF37))),
            ),
          ],
        );
      },
    );
  }
}

// 6. المشتريات والمصروفات
class PurchasesAndExpensesScreen extends StatefulWidget {
  const PurchasesAndExpensesScreen({Key? key}) : super(key: key);

  @override
  _PurchasesAndExpensesScreenState createState() => _PurchasesAndExpensesScreenState();
}

class _PurchasesAndExpensesScreenState extends State<PurchasesAndExpensesScreen> {
  int _selectedTab = 0;
  final TextEditingController supplierController = TextEditingController();
  final TextEditingController purchaseAmountController = TextEditingController();
  String purchasePaymentMethod = 'نقدي (كاش)';

  String expenseCategory = 'إيجار';
  final TextEditingController expenseAmountController = TextEditingController();
  final TextEditingController expenseNotesController = TextEditingController();
  String expensePaymentMethod = 'نقدي (كاش)';

  final List<String> expenseCategories = ['إيجار', 'كهرباء ومرافق', 'مطبوعات وأكياس', 'شحن ونقل', 'صيانة', 'أخرى'];
  final List<String> paymentMethods = ['نقدي (كاش)', 'إنستاباي (InstaPay)', 'فودافون كاش', 'آجل'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('المشتريات والمصروفات - أطياب الفخامة', style: TextStyle(color: Color(0xFFD4AF37))),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: Colors.brown.shade100,
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => setState(() => _selectedTab = 0),
                    icon: const Icon(Icons.shopping_cart, color: Colors.black),
                    label: Text('المشتريات', style: TextStyle(fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.normal, color: Colors.black)),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => setState(() => _selectedTab = 1),
                    icon: const Icon(Icons.money_off, color: Colors.black),
                    label: Text('المصروفات', style: TextStyle(fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.normal, color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _selectedTab == 0 ? _buildPurchasesForm() : _buildExpensesForm(),
    );
  }

  Widget _buildPurchasesForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text('تسجيل فاتورة مشتريات (موردين)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 15),
          TextField(controller: supplierController, decoration: const InputDecoration(labelText: 'اسم المورد أو الشركة', border: OutlineInputBorder(), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 15),
          TextField(controller: purchaseAmountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'إجمالي القيمة (ج.م)', border: OutlineInputBorder(), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 15),
          DropdownButtonFormField<String>(
            value: purchasePaymentMethod,
            decoration: const InputDecoration(labelText: 'طريقة الدفع', border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
            items: paymentMethods.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
            onChanged: (val) => setState(() => purchasePaymentMethod = val!),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حفظ المشتريات بنجاح')));
            },
            child: const Text('حفظ المشتريات', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text('تسجيل المصروفات النثرية والتشغيلية', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 15),
          DropdownButtonFormField<String>(
            value: expenseCategory,
            decoration: const InputDecoration(labelText: 'فئة المصروف', border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
            items: expenseCategories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (val) => setState(() => expenseCategory = val!),
          ),
          const SizedBox(height: 15),
          TextField(controller: expenseAmountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'المبلغ (ج.م)', border: OutlineInputBorder(), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 15),
          TextField(controller: expenseNotesController, decoration: const InputDecoration(labelText: 'ملاحظات أو بيان', border: OutlineInputBorder(), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تسجيل المصروف بنجاح')));
            },
            child: const Text('حفظ المصروف', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

// 7. التقارير المالية والمقارنات
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String selectedYear = '2026';
  final List<String> years = ['2025', '2026', '2027'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('التقارير المالية والمقارنات - أطياب الفخامة', style: TextStyle(color: Color(0xFFD4AF37))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('اختر السنة المالية:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                DropdownButton<String>(
                  value: selectedYear,
                  items: years.map((y) => DropdownMenuItem(value: y, child: Text(y, style: const TextStyle(fontWeight: FontWeight.bold)))).toList(),
                  onChanged: (val) => setState(() => selectedYear = val!),
                ),
              ],
            ),
            const Divider(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.brown.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('صافي الربح الفعلي', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12)),
                  SizedBox(height: 8),
                  Text('48,350 ج.م', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('مقارنة بالشهر السابق: +14.2% 📈', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('التحليل المقارن للأداء', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            _buildComparisonCard('مقارنة الأيام (اليوم vs نفس اليوم الأسبوع الماضي)', '+8.5%', Colors.green),
            _buildComparisonCard('مقارنة الشهور (الشهر الحالي vs السابق)', '+12.1%', Colors.green),
            _buildComparisonCard('مقارنة السنين (عام $selectedYear vs الماضي)', '+22.4%', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonCard(String title, String percentage, Color color) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        trailing: Text(percentage, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
