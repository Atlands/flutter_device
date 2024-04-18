import 'package:web/web.dart';

// @JS('WEBGL_debug_renderer_info')
// class WebGLDebugRendererInfo {
//   external int get UNMASKED_RENDERER_WEBGL;
//
//   external int get UNMASKED_VENDOR_WEBGL;
// }

class DeviceWeb {
  static Map<String, dynamic> getInfo() {
    String userAgent = window.navigator.userAgent.toLowerCase();
    String os = '';
    String version = '';
    String model = '';
    String brands = '';

    // 获取操作系统
    if (userAgent.contains('iphone')) {
      os = 'iOS';
    } else if (userAgent.contains('ipad')) {
      os = 'iOS';
      model = 'iPad';
      brands = model;
    } else if (userAgent.contains('android')) {
      os = 'Android';
    }

    // 获取华为信息
    if (userAgent.contains('hmscore')) {
      List<String> hms = userAgent.split(')')[0].split('hmscore')[0].split(';');
      model = hms[hms.length - 2];
    }
    version = window.navigator.appVersion.split('(').first;

    // 处理iOS系统
    if (os == 'iOS') {
      if (userAgent.contains('iphone')) {
        List<List<dynamic>> iphoneArr = [
          ['430,932,3', 'A15', 'iPhone 14 Pro Max'],
          ['393,852,3', 'A15', 'iPhone 14 Pro'],
          ['375,812,3', 'A15', 'iPhone 13(12) min'],
          ['428,926,3', 'A14', 'iPhone 14(12/13) Plus'],
          ['390,844,3', 'A14', 'iPhone 14(12/13)'],
          ['414,896,3', 'A13', 'iPhone 11 Pro Max(Xs Max)'],
          ['375,812,3', 'A13', 'iPhone 11 Pro(X/Xs)'],
          ['414,896,2', 'A13', 'iPhone 11(XR)'],
          ['414,736,3', 'A12', 'iPhone 8(7/6s) Plus'],
          ['375,667,2', 'A11', 'iPhone 8(7/6)'],
          ['320,568,2', 'A11', 'iPhone 5(s/se)'],
          ['320,480,2', 'A10', 'iPhone 4(s)'],
        ];

        // String? iphoneGPU;
        // var canvas = document.createElement('canvas') as HTMLCanvasElement;
        // var gl =
        //     canvas.getContext('experimental-webgl') as WebGLRenderingContext?;
        // if (gl != null) {
        //   var debugInfo = gl.getExtension("WEBGL_debug_renderer_info");
        //   if(debugInfo != null) {
        //     var parameter = debugInfo["UNMASKED_RENDERER_WEBGL" as JSAny];
        //     iphoneGPU =
        //     gl.getParameter(parameter as int) as String?;
        //   }
        // }
        var width = window.screen.width;
        var height = window.screen.height;
        var devicePixelRatio = window.devicePixelRatio;
        print('canvas 5');
        String baseInfo = '$width,$height,$devicePixelRatio';
        print('canvas 6');
        for (var item in iphoneArr) {
          if (item[0] == baseInfo) {
            model = item[2];
            // print('iphoneGPU: ${iphoneGPU == item[1]}');
            break;
          }
        }
        brands = model;
      } else {
        model = "iPad";
        brands = model;
      }
    }

    // 处理Android系统
    if (os == 'Android') {
      int j = -1;
      List<String> sss = userAgent.split(';');
      for (int i = 0; i < sss.length; i++) {
        if (sss[i].indexOf('build/') > 0) {
          j = i;
          break;
        }
      }
      if (j > -1) {
        model = sss[j].substring(0, sss[j].indexOf('build/'));
      }

      var judeBrand = judgeBrand(userAgent);
      for (var item in arrModal) {
        if (item['type'] == judeBrand) {
          brands = item['type'];
          List<dynamic> modelNumbers = item['modelNumber'];
          for (var vm in modelNumbers) {
            if (vm['lable'] == model.trim()) {
              brands = vm['value'];
              break;
            }
          }
        }
      }
    }

    return {
      'system': os,
      'version': version,
      'phoneModel': model,
      'mobile_model': model,
      'brands': brands
    };
  }

  static String judgeBrand(String userAgent) {
    bool isIphone = RegExp(r'iphone', caseSensitive: false).hasMatch(userAgent);
    bool isIpad = RegExp(r'ipad', caseSensitive: false).hasMatch(userAgent);
    bool isHuawei = RegExp(r'huawei', caseSensitive: false).hasMatch(userAgent);
    bool isHonor = RegExp(r'honor', caseSensitive: false).hasMatch(userAgent);
    bool isOppo = RegExp(r'oppo', caseSensitive: false).hasMatch(userAgent);
    bool isOppoR15 =
        RegExp(r'pacm00', caseSensitive: false).hasMatch(userAgent);
    bool isVivo = RegExp(r'vivo', caseSensitive: false).hasMatch(userAgent);
    bool isXiaomi = RegExp(r'mi\s', caseSensitive: false).hasMatch(userAgent);
    bool isXiaomi2s =
        RegExp(r'mix\s', caseSensitive: false).hasMatch(userAgent);
    bool isRedmi = RegExp(r'redmi', caseSensitive: false).hasMatch(userAgent);
    bool isSamsung = RegExp(r'sm-', caseSensitive: false).hasMatch(userAgent);
    bool isLg = RegExp(r'lg', caseSensitive: false).hasMatch(userAgent);

    if (isIphone) {
      return "iPhone";
    } else if (isIpad) {
      return "iPad";
    } else if (isHuawei || isHonor) {
      return "Huawei";
    } else if (isOppo || isOppoR15) {
      return "Oppo";
    } else if (isVivo) {
      return "vivo";
    } else if (isXiaomi || isRedmi || isXiaomi2s) {
      return "mi";
    } else if (isSamsung) {
      return "Samsung";
    } else if (isLg) {
      return "LG";
    } else {
      return "";
    }
  }
}

final List<Map<String, dynamic>> arrModal = [
  {
    'type': 'Huawei',
    'modelNumber': [
      {'lable': 'NOH-AN50', 'value': '华为Mate40E Pro'},
      {'lable': 'NOH-AN50', 'value': '华为Mate40E Pro'},
      {'lable': 'ABR-AL60', 'value': '华为P50E'},
      {'lable': 'BRQ-AN00', 'value': '华为nova8 Pro'},
      {'lable': 'JLN-AL00', 'value': '华为nova 9 SE'},
      {'lable': 'CHA-AL80', 'value': '华为nova 10z'},
      {'lable': 'MGA-AL00', 'value': '华为畅享 50'},
      {'lable': 'NCO-AL00', 'value': '华为nova 10'},
      {'lable': 'GLA-AL00', 'value': '华为nova 10 Pro'},
      {'lable': 'TET-AN50', 'value': '华为Mate Xs 2'},
      {'lable': 'RTE-AL00', 'value': '华为nova 9 Pro'},
      {'lable': 'NAM-AL00', 'value': '华为nova 9'},
      {'lable': 'BAL-AL80', 'value': '华为P50 Pocket S'},
      {'lable': 'JAD-AL50', 'value': '华为P50 Pro'},
      {'lable': 'NOH-AN50', 'value': '华为Mate40E'},
      {'lable': 'OCE-AN00', 'value': '华为Mate40'},
      {'lable': 'NOH-AN00', 'value': '华为Mate40 Pro'},
      {'lable': 'NOP-AN00', 'value': '华为Mate40 Pro+'},
      {'lable': 'ANA-AN00', 'value': '华为P40'},
      {'lable': 'ANA-TN00', 'value': '华为P40'},
      {'lable': 'ELS-AN00', 'value': '华为P40 Pro'},
      {'lable': 'ELS-TN00', 'value': '华为P40 Pro'},
      {'lable': 'ELS-AN10', 'value': '华为P40 Pro Premium Edition'},
      {'lable': 'CET-AL60', 'value': '华为 Mate 50E'},
      {'lable': 'BNE-AL00', 'value': '华为 Mate 50'},
      {'lable': 'CTR-AL00', 'value': '华为畅享 50 Pro'},
      {'lable': 'STK-AL00', 'value': '华为畅享 10 Pro'},
      {'lable': 'CET-AL00', 'value': '华为 Mate 50 RS'},
      {'lable': 'DCO-AL00', 'value': '华为 Mate 50 Pro'},
      {'lable': 'JSC-AN00', 'value': '华为nova 8 SE'},
      {'lable': 'ANG-AN00', 'value': '华为nova 8'},
      {'lable': 'OCE-AN00', 'value': '华为Mate40'},
      {'lable': 'NOH-AN00', 'value': '华为Mate40 Pro'},
      {'lable': 'NOP-AN00', 'value': '华为Mate40 Pro+'},
      {'lable': 'LIO-AL00', 'value': '华为Mate30E Pro'},
      {'lable': 'CindyN-AN00', 'value': '华为nova 7 SE'},
      {'lable': 'ELE-AL00', 'value': '华为P30'},
      {'lable': 'VOG-AL10', 'value': '华为P30 Pro'},
      {'lable': 'HMA-AL00', 'value': '华为Mate20'},
      {'lable': 'EML-AL00', 'value': '华为P20'},
      {'lable': 'CLT-AL00', 'value': '华为P20 Pro'},
      {'lable': 'LYA-AL00', 'value': '华为Mate20 Pro'},
      {'lable': 'LIO-AN00', 'value': '华为Mate30 Pro'},
      {'lable': 'VOG-AL00', 'value': '华为P30 Pro'},
      {'lable': 'SEA-AL10', 'value': '华为nova5 Pro'},
      {'lable': 'TAS-AN00', 'value': '华为Mate30'},
      {'lable': 'TAS-AL00', 'value': '华为Mate30'},
      {'lable': 'PAR-AL00', 'value': '华为Nova 3'},
      {'lable': 'VCE-AL00', 'value': '华为Nova 4'},
      {'lable': 'ADT-AN00', 'value': '荣耀X40 GT'},
      {'lable': 'VNE-AN40', 'value': '荣耀Play6C'},
      {'lable': 'FNE-AN00', 'value': '荣耀70 Pro'},
      {'lable': 'HPB-AN00', 'value': '荣耀70 Pro+'},
      {'lable': 'VNE-AN00', 'value': '荣耀畅玩30'},
      {'lable': 'CMA-AN40', 'value': '荣耀Play6T'},
      {'lable': 'LGE-AN20', 'value': '荣耀Magic4 至臻版'},
      {'lable': 'TFY-AN40', 'value': '荣耀Play6T Pro'},
      {'lable': 'LGE-AN00', 'value': '荣耀Magic4'},
      {'lable': 'LGE-AN10', 'value': '荣耀Magic4 Pro'},
      {'lable': 'TFY-AN40', 'value': '荣耀60 SE'},
      {'lable': 'MGI-AN00', 'value': '荣耀Magic V'},
      {'lable': 'DIO-AN00', 'value': '荣耀X40i'},
      {'lable': 'ANY-AN00', 'value': '荣耀X30'},
      {'lable': 'EDG-AN00', 'value': '荣耀X30i'},
      {'lable': 'TFY-AN00', 'value': '荣耀X30i'},
      {'lable': 'KKG-AN70', 'value': '荣耀X30 Max'},
      {'lable': 'CMA-AN00', 'value': '荣耀畅玩30 Plus'},
      {'lable': 'TNA-AN00', 'value': '荣耀60 Pro'},
      {'lable': 'LSA-AN00', 'value': '荣耀60'},
      {'lable': 'ELZ-AN10', 'value': '荣耀Magic3 Pro'},
      {'lable': 'ELZ-AN20', 'value': '荣耀Magic3 至臻版'},
      {'lable': 'JLH-AN00', 'value': '荣耀50 SE'},
      {'lable': 'CHL-AN00', 'value': '荣耀X20 SE'},
      {'lable': 'NTN-AN00', 'value': '荣耀50'},
    ],
  },
  {
    'type': 'vivo',
    'modelNumber': [
      {'lable': 'V1731CA', 'value': 'vivo Y73t'},
      {'lable': 'V2166BA', 'value': 'vivo Y77e'},
      {'lable': 'V2219A', 'value': 'vivo Y77'},
      {'lable': 'V2188A', 'value': 'vivo T2x'},
      {'lable': 'V2170A', 'value': 'vivo X Note'},
      {'lable': 'V2178A', 'value': 'vivo X Fold'},
      {'lable': 'V2166A', 'value': 'vivo Y33s'},
      {'lable': 'V2168A', 'value': 'vivo Y10(t1)'},
      {'lable': 'V2229A', 'value': 'vivo X Fold+'},
      {'lable': 'V2183A', 'value': 'vivo X80'},
      {'lable': 'V2207A', 'value': 'vivo S15 Pro'},
      {'lable': 'V2203A', 'value': 'vivo S15'},
      {'lable': 'V2185A', 'value': 'vivo X80 Pro'},
      {'lable': 'V2199A', 'value': 'vivo S15e'},
      {'lable': 'V2199GA', 'value': 'vivo S15 Pro'},
      {'lable': 'V2185A', 'value': 'vivo X80 Pro'},
      {'lable': 'V2162A', 'value': 'vivo S12'},
      {'lable': 'V2156A', 'value': 'vivo Y55s'},
      {'lable': 'V2163A', 'value': 'vivo S12 Pro'},
      {'lable': 'V2158A', 'value': 'vivo Y32'},
      {'lable': 'V2123A', 'value': 'vivo X70'},
      {'lable': 'V2156A', 'value': 'vivo Y76s'},
      {'lable': 'V2130A', 'value': 'vivo S10e'},
      {'lable': 'V2134A', 'value': 'vivo X70 Pro'},
      {'lable': 'V2123A', 'value': 'vivo X70'},
      {'lable': 'V2125A', 'value': 'vivo X70 Pro+'},
      {'lable': 'V2111A', 'value': 'vivo Y53s'},
      {'lable': 'V2121A', 'value': 'vivo S10 Pro'},
      {'lable': 'V2121A', 'value': 'vivo S10'},
      {'lable': 'V2059A', 'value': 'vivo X60'},
      {'lable': 'V2068A', 'value': 'vivo Y31s'},
      {'lable': 'V2056A', 'value': 'vivo X60t Pro+'},
      {'lable': 'V2057A', 'value': 'vivo Y52s'},
      {'lable': 'V2072A', 'value': 'vivo S9'},
      {'lable': 'V2048A', 'value': 'vivo S9e'},
      {'lable': 'V2034A', 'value': 'vivo Y30g'},
      {'lable': 'V2085A', 'value': 'vivo X60t'},
      {'lable': 'V2080A', 'value': 'vivo S7t'},
      {'lable': 'V2034A', 'value': 'vivo Y30'},
      {'lable': 'V2031EA', 'value': 'vivo S7e'},
      {'lable': 'V2031A', 'value': 'vivo Y73s'},
      {'lable': 'V2020A', 'value': 'vivo Y3s'},
      {'lable': 'TAS-AN00', 'value': 'vivo S7'},
    ],
  },
  {
    'type': 'Samsung',
    'modelNumber': [
      {'lable': 'SM-G965U', 'value': 'Samsung S9+'},
      {'lable': 'SM-W9023', 'value': 'Samsung W23'},
      {'lable': 'SM-W7023', 'value': 'Samsung W23 Flip'},
      {'lable': 'SM-S9010', 'value': 'Samsung Galaxy S22'},
      {'lable': 'SM-S9060', 'value': 'Samsung Galaxy S22 Plus'},
      {'lable': 'SM-S9080', 'value': 'Samsung Galaxy S22 Note'},
      {'lable': 'SM-G9900', 'value': 'Samsung Galaxy S21 FE'},
      {'lable': 'SM-G998U', 'value': 'Samsung Galaxy S21 Ultra'},
      {'lable': 'SM-F7210', 'value': 'Samsung Galaxy Z Flip4'},
      {'lable': 'SM-F9360', 'value': 'Samsung Galaxy Z Fold4'},
      {'lable': 'SM-W9023', 'value': 'Samsung W22'},
      {'lable': 'SM-F7110', 'value': 'Samsung Z Flip3'},
      {'lable': 'SM-F9260', 'value': 'Samsung Z Fold3'},
      {'lable': 'SM-E5260', 'value': 'Samsung F52'},
      {'lable': 'SM-A5260', 'value': 'Samsung Galaxy A52'},
      {'lable': 'SM-G998U', 'value': 'Samsung Galaxy S21 Ultra'},
      {'lable': 'SM-G9980', 'value': 'Samsung Galaxy S21 Ultra'},
      {'lable': 'SM-G9910', 'value': 'Samsung S21'},
      {'lable': 'SM-G9960', 'value': 'Samsung S21+'},
      {'lable': 'SM-A326B', 'value': 'Samsung Galaxy A32'},
    ],
  },
];
