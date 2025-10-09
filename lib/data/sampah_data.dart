// File: sampah_data.dart
// Data ini berisi semua kategori, icon, dan detail sub-kategori beserta harganya.

final List<Map<String, dynamic>> allCategoriesData = [
  {
    'icon': '♻️',
    'name': 'Plastik',
    'gridLabel': 'Plastik', // Label singkat untuk Grid di Home Screen
    'subCategories': [
      {
        'subName': 'Botol PET Bening',
        'price': 'Rp4.500/Kg',
        'desc': 'Air mineral, soda',
      },
      {
        'subName': 'Plastik HD (Warna)',
        'price': 'Rp2.000/Kg',
        'desc': 'Ember, jerigen, galon',
      },
      {
        'subName': 'Plastik Campur',
        'price': 'Rp500/Kg',
        'desc': 'Sachet, kresek tipis',
      },
    ],
  },
  {
    'icon': '📦',
    'name': 'Kertas & Kardus',
    'gridLabel': 'Kertas/\nKardus',
    'subCategories': [
      {
        'subName': 'Kardus Bekas',
        'price': 'Rp2.200/Kg',
        'desc': 'Dus mie instan, kotak packing',
      },
      {
        'subName': 'Kertas HVS/Arsip',
        'price': 'Rp3.500/Kg',
        'desc': 'Kertas kantor putih',
      },
      {
        'subName': 'Koran Bekas',
        'price': 'Rp1.000/Kg',
        'desc': 'Kertas koran, majalah',
      },
    ],
  },
  {
    'icon': '⚙️',
    'name': 'Logam / Besi',
    'gridLabel': 'Logam',
    'subCategories': [
      {
        'subName': 'Besi Tua',
        'price': 'Rp4.000/Kg',
        'desc': 'Rangka besi, paku, kaleng besar',
      },
      {
        'subName': 'Aluminium',
        'price': 'Rp15.000/Kg',
        'desc': 'Kaleng minuman, panci',
      },
    ],
  },
  {
    'icon': '🔋',
    'name': 'Elektronik / E-Waste',
    'gridLabel': 'Elektronik',
    'subCategories': [
      {
        'subName': 'HP & Laptop Bekas',
        'price': 'Negotiable',
        'desc': 'Dihargai per unit',
      },
      {
        'subName': 'Kabel Tembaga',
        'price': 'Rp30.000/Kg',
        'desc': 'Kabel listrik, adaptor rusak',
      },
    ],
  },
  {
    'icon': '🚗',
    'name': 'Otomotif',
    'gridLabel': 'Otomotif',
    'subCategories': [
      {
        'subName': 'Aki Bekas',
        'price': 'Rp12.000/Kg',
        'desc': 'Aki mobil/motor',
      },
      {'subName': 'Ban Bekas', 'price': 'Rp500/Kg', 'desc': 'Ban mobil/motor'},
    ],
  },
  {
    'icon': '🏠',
    'name': 'Barang Rumah Tangga',
    'gridLabel': 'Rumah\nTangga',
    'subCategories': [
      {
        'subName': 'Panci & Wajan Rusak',
        'price': 'Rp2.000/Kg',
        'desc': 'Peralatan masak dari logam campuran',
      },
      {
        'subName': 'Kipas Angin Rusak',
        'price': 'Rp5.000/Kg',
        'desc': 'Dihargai per unit',
      },
    ],
  },
  {
    'icon': '👕',
    'name': 'Tekstil / Kain',
    'gridLabel': 'Tekstil/\nKain',
    'subCategories': [
      {
        'subName': 'Baju Layak Jual',
        'price': 'Negotiable',
        'desc': 'Pakaian bekas yang masih bagus',
      },
      {
        'subName': 'Kain Perca/Karung',
        'price': 'Rp300/Kg',
        'desc': 'Kain kotor, potongan kain',
      },
    ],
  },
  {
    'icon': '🧱',
    'name': 'Lain-lain',
    'gridLabel': 'Lain-lain',
    'subCategories': [
      {
        'subName': 'Botol Kaca Bening',
        'price': 'Rp1.000/Kg',
        'desc': 'Botol kecap, sirup',
      },
      {
        'subName': 'Minyak Jelantah',
        'price': 'Rp3.000/Liter',
        'desc': 'Minyak goreng bekas',
      },
    ],
  },
];
