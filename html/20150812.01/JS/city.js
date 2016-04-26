var _city=new Array(35); 
_city[0]=new Array(["请选择省份","请先选择省份"],[0,0]); 
_city[1]=new Array(["北京","北京"],[2,201]); 
_city[2]=new Array(["重庆","重庆"],[3,301]); 
_city[3]=new Array(["福建","福州市","龙岩地区","南平地区","宁德地区","莆田市","泉州市","三明市","厦门市","漳州市"],[4,401,402,403,404,405,406,407,408,409]); 
_city[4]=new Array(["甘肃","白银市","定西地区","甘南藏族自治州","嘉峪关市","金昌市","酒泉地区","兰州市","临夏回族自治州","陇南地区","平凉地区","庆阳地区","天水市","武威地区","张掖地区"],[5,501,502,503,504,505,506,507,508,509,510,511,512,513,514]); 
_city[5]=new Array(["广东","潮州市","东莞市","佛山市","广州市","河源市","惠州市","江门市","揭阳市","茂名市","梅州市","清远市","汕头市","汕尾市","韶关市","深圳市","阳江市","湛江市","肇庆市","中山市","珠海市"],[6,601,602,603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,619,620]); 
_city[6]=new Array(["广西","百色地区","北海市","桂林地区","桂林市","河池地区","柳州地区","柳州市","南宁地区","南宁市","钦州地区","梧州地区","梧州市","玉林地区"],[7,701,702,703,704,705,706,707,708,709,710,711,713]); 
_city[7]=new Array(["贵州","安顺地区","毕节地区","贵阳市","六盘水市","黔东南苗族侗族自治州","黔南布依族苗族自治州","黔西南布依族苗族自治州","铜仁地区","遵义地区"],[8,801,802,803,804,805,806,807,808,809]); 
_city[8]=new Array(["海南","白沙黎族自治县","保亭黎族苗族自治县","昌江黎族自治县","澄迈县","儋县","定安县","东方黎族自治县","海口市","乐东黎族自治县","临高县","陵水黎族自治县","南沙群岛","琼海市","琼山县","琼中黎族苗族自治县","三亚市","通什市","屯昌县","万宁县","文昌县","西沙群岛","中沙群岛的岛礁及其海域"],[9,901,902,903,904,905,906,907,908,909,910,911,912,913,914,915,916,917,918,919,920,921,922]); 
_city[9]=new Array(["安徽","安庆市","蚌埠市","巢湖地区","池州地区","滁州市","阜阳地区","合肥市","淮北市","淮南市","黄山市","六安地区","马鞍山市","宿县地区","铜陵市","芜湖市","宣城地区"],[1,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116]); 
_city[10]=new Array(["河北","保定地区","保定市","沧州地区","沧州市","承德地区","承德市","邯郸地区","邯郸市","衡水地区","廊坊市","秦皇岛市","石家庄地区","石家庄市","唐山市","邢台地区","邢台市","张家口地区","张家口市"],[10,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022]); 
_city[11]=new Array(["河南","安阳市","鹤壁市","焦作市","开封市","洛阳市","漯河市","南阳地区","平顶山市","濮阳市","三门峡市","商丘地区","新乡市","信阳地区","许昌市","郑州市","周口地区","驻马店地区"],[11,1101,1102,1103,1104,1105,1106,1107,1108,1109,1110,1111,1112,1113,1114,1115,1116,1117,1118,1119,1120,1121,1122]); 
_city[12]=new Array(["黑龙江","大庆市","大兴安岭地区","哈尔滨市","鹤岗市","黑河地区","鸡西市","佳木斯市","牡丹江市","七台河市","齐齐哈尔市","双鸭山市","松花江地区","绥化地区","伊春市"],[12,1201,1202,1203,1204,1205,1206,1207,1208,1209,1210,1211,1212,1213,1214,1215,1216,1217,1218,1219,1220,1221,1222]); 
_city[13]=new Array(["湖北","鄂西土家族苗族自治州","鄂州市","黄冈地区","黄石市","荆门市","荆州地区","沙市市","省直辖行政单位","十堰市","武汉市","咸宁地区","襄樊市","孝感地区","宜昌市","郧阳地区"],[13,1301,1302,1303,1304,1305,1306,1307,1308,1309,1310,1311,1312,1313,1314,1315,1316,1317,1318,1319,1320,1321,1322]); 
_city[14]=new Array(["湖南","长沙市","常德市","郴州地区","大庸市","衡阳市","怀化地区","零陵地区","娄底地区","邵阳市","湘潭市","湘西土家族苗族自治州","益阳地区","岳阳市","株洲市"],[14,1401,1402,1403,1404,1405,1406,1407,1408,1409,1410,1411,1412,1413,1414,1415,1416,1417,1418,1419,1420,1421,1422]); 
_city[15]=new Array(["吉林","白城地区","长春市","浑江市","吉林市","辽源市","四平市","松原市","通化市","延边朝鲜族自治州"],[15,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1518,1519,1520,1521,1522]); 
_city[16]=new Array(["江苏","常州市","淮阴市","连云港市","南京市","南通市","苏州市","无锡市","徐州市","盐城市","扬州市","镇江市"],[16,1601,1602,1603,1604,1605,1606,1607,1608,1609,1610,1611,1612,1613,1614,1615,1616,1617,1618,1619,1620,1621,1622]); 
_city[17]=new Array(["江西","抚州地区","赣州地区","吉安地区","景德镇市","九江市","南昌市","萍乡市","上饶地区","新余市","宜春地区","鹰潭市"],[17,1701,1702,1703,1704,1705,1706,1707,1708,1709,1710,1711,1712,1713,1714,1715,1716,1717,1718,1719,1720,1721,1722]); 
_city[18]=new Array(["辽宁","鞍山市","本溪市","朝阳市","大连市","丹东市","抚顺市","阜新市","锦西市","锦州市","辽阳市","盘锦市","沈阳市","铁岭市","营口市"],[18,1801,1802,1803,1804,1805,1806,1807,1808,1809,1810,1811,1812,1813,1814,1815,1816,1817,1818,1819,1820,1821,1822]); 
_city[19]=new Array(["内蒙古","阿拉善盟","巴彦淖尔盟","包头市","赤峰市","呼和浩特市","呼伦贝尔盟","乌海市","乌兰察布盟","锡林郭勒盟","兴安盟","伊克昭盟","哲里木盟"],[19,1901,1902,1903,1904,1905,1906,1907,1908,1909,1910,1911,1912,1913,1914,1915,1916,1917,1918,1919,1920,1921,1922]); 
_city[20]=new Array(["宁夏","固原地区","石嘴山市","银川市","银南地区"],[20,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022]); 
_city[21]=new Array(["青海","果洛藏族自治州","海北藏族自治州","海东地区","海南藏族自治州","海西蒙古族藏族自治州","黄南藏族自治州","西宁市","玉树藏族自治州"],[21,2101,2102,2103,2104,2105,2106,2107,2108,2109,2110,2111,2112,2113,2114,2115,2116,2117,2118,2119,2120,2121,2122]); 
_city[22]=new Array(["山东","滨州地区","德州地区","东营市","菏泽地区","济南市","济宁市","莱芜市","聊城地区","临沂地区","青岛市","日照市","泰安市","威海市","潍坊市","烟台市","枣庄市","淄博市"],[22,2201,2202,2203,2204,2205,2206,2207,2208,2209,2210,2211,2212,2213,2214,2215,2216,2217,2218,2219,2220,2221,2222]); 
_city[23]=new Array(["山西","长治市","大同市","晋城市","晋中地区","临汾地区","吕梁地区","朔州市","太原市","忻州地区","雁北地区","阳泉市","运城地区"],[23,2301,2302,2303,2304,2305,2306,2307,2308,2309,2310,2311,2312,2313,2314,2315,2316,2317,2318,2319,2320,2321,2322]); 
_city[24]=new Array(["陕西","安康地区","宝鸡市","汉中地区","商洛地区","铜川市","渭南地区","西安市","咸阳市","延安地区","榆林地区"],[24,2401,2402,2403,2404,2405,2406,2407,2408,2409,2410,2411,2412,2413,2414,2415,2416,2417,2418,2419,2420,2421,2422]); 
_city[25]=new Array(["上海","上海"],[25,2501]); 
_city[26]=new Array(["四川","阿坝藏族羌族自治州","成都市","达县地区","德阳市","涪陵地区","甘孜藏族自治州","广元市","乐山市","凉山彝族自治州","泸州市","绵阳市","内江市","南充地区","攀枝花市","黔江地区","遂宁市","万县市","雅安地区","宜宾地区","自贡市","广安市"],[26,2601,2602,2603,2604,2605,2606,2607,2608,2609,2610,2611,2612,2613,2614,2615,2616,2617,2618,2619,2620,2621,2622]); 
_city[27]=new Array(["台湾","台湾"],[27,2701]); 
_city[28]=new Array(["天津","天津"],[28,2801]); 
_city[29]=new Array(["西藏","阿里地区","昌都地区","拉萨市","林芝地区","那曲地区","日喀则地区","山南地区"],[29,2901,2902,2903,2904,2905,2906,2907,2908,2909,2910,2911,2912,2913,2914,2915,2916,2917,2918,2919,2920,2921,2922]); 
_city[30]=new Array(["新疆","阿克苏地区","阿勒泰地区","巴音郭楞蒙古自治州","博尔塔拉蒙古自治州","昌吉回族自治州","哈密地区","和田地区","喀什地区","克拉玛依市","克孜勒苏柯尔克孜自治州","省直辖行政单位","塔城地区","吐鲁番地区","乌鲁木齐市","伊犁地区","伊犁哈萨克自治州"],[30,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3021,3022]); 
_city[31]=new Array(["云南","保山地区","楚雄彝族自治州","大理白族自治州","德宏傣族景颇族自治州","迪庆藏族自治州","东川市","红河哈尼族彝族自治州","昆明市","丽江地区","临沧地区","怒江傈僳族自治州","曲靖地区","思茅地区","文山壮族苗族自治州","西双版纳傣族自治州","玉溪地区","昭通地区"],[31,3101,3102,3103,3104,3105,3106,3107,3108,3109,3110,3111,3112,3113,3114,3115,3116,3117,3118,3119,3120,3121,3122]); 
_city[32]=new Array(["浙江","杭州市","湖州市","嘉兴市","金华市","丽水地区","宁波市","衢州市","绍兴市","台州地区","温州市","舟山市"],[32,3201,3202,3203,3204,3205,3206,3207,3208,3209,3210,3211,3212,3213,3214,3215,3216,3217,3218,3219,3220,3221,3222]); 
_city[33]=new Array(["港澳","香港","澳门"],[33,3301,3302]); 
_city[34]=new Array(["海外","海外"],[34,3401]); 
 
 
function loadProvince(id) 
{ 
 var obj=document.getElementById(id); 
 for(var i=0;i<_city.length;i++) 
 { 
  if(_city[i]) 
  { 
   /*obj.options[obj.length]=new Option(_city[i][0][0],_city[i][1][0]);*/ 
   obj.options[obj.length]=new Option(_city[i][0][0],_city[i][0][0]);
  } 
 } 
} 
 
function loadCity(obj,id) 
{ 
 var obj1=document.getElementById(id); 
 var index=obj.selectedIndex; 
 obj1.length=0; 
 for(var i=1;i<_city[index][0].length;i++) 
  /*obj1.options[obj1.length]=new Option(_city[index][0][i],_city[index][1][i]); */
  obj1.options[obj1.length]=new Option(_city[index][0][i],_city[index][0][i]);
  obj1.selectedIndex=0; 
} 