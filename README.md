# HoseProduct
房产金融app，（主要技术：原生态与前端web，完美交互。）


----------- < PrefixHeader > -------------------

#pragma mark----------- < UIScreen > -------------------

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#pragma mark----------- < Alert提示 > -------------------

#define Alert(s, d) [[[UIAlertView alloc] initWithTitle:s message:d delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show]

#pragma mark----------- < BundleImageLoad > -------------------

#define LOADIMAGE(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:nil]]

#pragma mark----------- < LoadNib > -------------------

#define LoadNib(nibName) [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject]

#pragma mark----------- < 测试颜色 > -------------------

#define KClearColor [UIColor clearColor] //透明色
#define KWhiteColor [UIColor whiteColor] //白色
#define KBlackColor [UIColor blackColor] //黑色
#define KRedColor   [UIColor redColor]   //红
#define KMainColor  RGB(228, 0, 6, 1)   //主题色
#define RGB(r, g, b, a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]


#pragma mark----------- < 持久化数据存储 > -------------------

#define U_Def [NSUserDefaults standardUserDefaults]

#define SetObjcForKey(objc, key) [U_Def setObject:objc forKey:key];\
[U_Def synchronize]
#define GetObjcForKey(key) [U_Def objectForKey:key]

#define SetBoolForKey(bool, key) [U_Def setBool:bool forKey:key];\
[U_Def synchronize]
#define GetBoolForKey(key) [U_Def boolForKey:key]

#define SetDoubleForKey(double, key) [U_Def setDouble:double forKey:key];\
[U_Def synchronize]
#define GetDoubleForKey(key) [U_Def doubleForKey:key]

#define SetFloatForKey(float, key) [U_Def setFloat:float forKey:key];\
[U_Def synchronize]
#define GetFloatForKey(key) [U_Def floatForKey:key]

#define SetIntegerForKey(integer, key) [U_Def setInteger:integer forKey:key];\
[U_Def synchronize]
#define GetIntegerForKey(key) [U_Def integerForKey:key]

#define SetURLForKey(URLString, key) [U_Def setURL: [NSURL URLWithString: URLString] forKey:key];\
[U_Def synchronize]
#define GetURLForKey(key) [U_Def URLForKey:key]


#pragma mark----------- < Notification > -------------------

#define Notifi_Post(notiName, dictInfo) [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil userInfo: dictInfo]
#define Notifi_AddOb(notiName, SEL) [[NSNotificationCenter defaultCenter] addObserver:self selector:SEL name:notiName object:nil]
#define Notifi_Remove(notiName) [[NSNotificationCenter defaultCenter] removeObserver: notiName]

#pragma mark----------- < FontSize > -------------------

#define FontSize(size) [UIFont systemFontOfSize: size]

#pragma mark----------- < AppDelegate > -------------------

#define App ((AppDelegate *)[UIApplication sharedApplication].delegate)

#pragma mark----------- < Format > -------------------

#define Format(obj) [NSString stringWithFormat:@"%@", obj]

#pragma mark----------- < 友盟的APPKey > -------------------

#define APP_URL       @"http://www.umeng.com/social"
#define UMAPP_KEY     @"58eb45dfb27b0a1e61001b7d"
#define WXAPP_ID      @"wx5de5e1ca72fcd5b7"
#define WXAPP_SECRET  @"d335924636cacefd1e7fec0b9ecaacb3"

