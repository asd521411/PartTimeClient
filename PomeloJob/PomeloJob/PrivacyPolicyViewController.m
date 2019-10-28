//
//  PrivacyPolicyViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/9.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PrivacyPolicyViewController.h"

@interface PrivacyPolicyViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *talbleV;

@property (nonatomic, copy) NSString *praStr;

@end

@implementation PrivacyPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"柚选隐私政策";
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    img.image = [UIImage imageNamed:@""];
    //[self.view addSubview:img];
    
    
    self.praStr = @"<p>本《软件使用及服务协议》（下称《协议》）是您（下称“用户”）与柚选兼职之间关于用户安装、使用、复制柚选兼职；注册、使用、管理柚选兼职帐号；以及使用柚选兼职相关服务所订立的协议。<br> <br>用户应认真阅读并充分理解此《软件使用及服务协议》。请审慎阅读并选择接受或不接受本《协议》（未成年人应在法定监护人陪同下阅读）。用户的安装、使用、帐号获取和登录等行为均被视为对本《协议》的接受，并同意接受各项条款的约束。<br> <br>本《协议》可由北京格鑫科技有限公司随时更新，更新后的协议条款一经公布，即时代替原来的协议条款，恕不再另行通知。用户可随时查阅最新版协议条款。在柚选兼职修改《协议》条款后，用户继续使用“柚选兼职”软件和服务将被视为已接受了修改后的协议。如果用户不接受修改后的条款，请立即停止使用。<br> <br>一、知识产权声明<br> <br>1.1“柚选兼职”是由北京格鑫科技有限公司开发，一切著作权、商标权、专利权、商业秘密等知识产权，以及相关的所有信息内容，包括但不限于：图标、图表、色彩、界面设计、版面框架、数据、电子文档等均受中华人民共和国著作权法、商标法、专利法、反不正当竞争法和相应的国际条约以及其他知识产权法律法规的保护，柚选兼职享有上述知识产权。<br> <br>    1.2 未经柚选兼职书面同意，用户不得以任何目的使用或转让上述知识产权，柚选兼职保留追究上述未经许可行为的权利。<br> <br>    二、帐号使用需知<br> <br>    2.1“柚选兼职”帐号的所有权归北京格鑫科技有限公司，用户完成注册后获得相应的使用权。用户承担“柚选兼职”帐号与密码的保管责任，并对所注册的帐号及密码下的一切活动负全部责任。<br> <br>    2.2用户的“柚选兼职”帐号在遗忘密码后，可以通过手机号验证来重置密码。柚选兼职只负责核对验证信息是否与帐号相关信息一致，而不对信息提供者身份进行证实，不对冒名验证行为承担任何责任。同时，柚选兼职不承诺通过帐号相关的个人信息进行验证一定能找回帐号。<br> <br>    2.3用户若违反用户协议以及“柚选兼职”内置社区相关规定，将被终止使用社区交流的权利。“柚选兼职”内置社区的相关规定将在社区内以公告帖的形式出现，并不定期更新【如更新后，用户继续使用内置社区，则默认用户完全赞同相关规定】。<br> <br>2.4 用户不得实施包括但不限于下列行为：<br> <br>通过非柚选兼职开发、授权或认可的软件、插件、外挂等登录或使用“柚选兼职”软件和服务。<br> <br>1、去除“柚选兼职”中的版权信息；<br> <br>2、对“柚选兼职”进行反向工程、反向汇编、反向编译等；<br> <br>3、使用“柚选兼职”发表、传播、储存违反国家法律、危害国家安全、祖国统一、社会稳定、公序良俗的内容，或任何不当的、侮辱诽谤的、淫秽的、暴力的及任何违反国家法律法规政策的内容；<br> <br>4、批量发表、传送、传播广告信息及垃圾信息；<br> <br>    5、以任何不合法的方式、为任何不合法的目的、或以任何与本协议不一致的方式使用本软件和和柚选兼职提供的其它服务。<br> <br>    2.5 用户若违反上述规定，柚选兼职有权在不事先通知用户的情况下终止用户帐号的在线功能。如果发布违法内容，柚选兼职收到举报，有权在24小时内对被举报内容删除和终止用户帐号的在线功能。<br> <br>    2.6使用“柚选兼职”必须遵守国家有关法律和政策并遵守本《协议》。对于用户违法或违反本《协议》的使用而引起的一切责任，由用户负全部责任，一概与柚选兼职及合作方无关。导致柚选兼职及合作方损失的，柚选兼职及合作方有权要求用户赔偿，并有权保留相关记录。<br> <br>    2.7 用户若通过非柚选兼职官方网站，或非柚选兼职授权网站下载的“柚选兼职”，将可能导致不可预知的风险，由此产生的一切法律责任与纠纷一概与柚选兼职无关。<br> <br>    2.8 柚选兼职有权在“柚选兼职”中投放不同形式的广告信息。<br> <br>    三、隐私保护<br> <br>    3.1个人隐私信息指可以用于对用户进行个人辨识或涉及个人通信的信息，包括：IP地址，电子邮件地址，以及用户在参与柚选兼职及合作方发起的特定活动时填写的姓名、身份证号、手机号码、联系地址。非个人隐私信息指用户在使用“柚选兼职”时的操作状态、设备信息以及使用习惯等明确客观记录在柚选兼职服务器端的基本记录信息，和其他一切个人隐私信息范围外的普通信息。<br> <br>    3.2 用户若参与柚选兼职及合作方发起的特定活动，需要向柚选兼职及合作方提供特定的个人隐私信息，柚选兼职及合作方不得向任何其它组织、单位和个人公开、透露相关信息。<br> <br>    3.3 柚选兼职会采取合理的措施保护用户的个人隐私信息，除法律或有法律赋予权限的政府部门要求或用户同意等原因外，柚选兼职未经用户同意不向除合作方以外的第三方公开、透露用户个人隐私信息。<br> <br>    3.4 为了改善柚选兼职的技术和服务，我们将可能会收集、使用用户的非个人隐私信息，以提供更好的用户体验和服务质量。<br> <br>    3.5 用户的日历记录会被自动上传至柚选兼职服务器，在用户使用“柚选兼职”帐号时，可以通过柚选兼职服务器自动备份和恢复日历记录。<br> <br>    3.6 用户的日历记录在与个人隐私信息解除关联的前提下，可能用于经期预测算法的优化。<br> <br>   四、法律责任与免责申明<br> <br>    4.1 柚选兼职将会尽其商业上的合理努力以保护用户的设备资源及通讯的隐私性和完整性，但是，用户承认和同意柚选兼职不能就此事提供任何保证。<br> <br>    4.2 柚选兼职可以根据用户的使用状态和行为，为了改进“柚选兼职”的功能、用户体验和服务，开发或调整软件功能。<br> <br>    4.3 柚选兼职为保障业务发展和调整的自主权，有权随时自行修改或中断软件服务而不需通知用户。<br> <br>    4.4 在任何情况下因使用或不能使用本“柚选兼职”所产生的直接、间接、偶然、特殊及后续的损害及风险，柚选兼职及合作方不承担任何责任。<br> <br>    4.5 因技术故障等不可抗事件影响到服务的正常运行的，柚选兼职及合作方承诺在第一时间内与相关单位配合，及时处理进行修复，但用户因此而遭受的一切损失，柚选兼职及合作方不承担责任。<br> <br>    4.6 用户通过“柚选兼职”与其他用户联系，因受误导或欺骗而导致或可能导致的任何心理、生理上的伤害以及经济上的损失，由过错方依法承担所有责任，一概与柚选兼职及合作方无关。<br>5.2柚选兼职隐私政策<br><br>为切实保护柚选兼职（包括柚选兼职旗下所有产品）用户的隐私权，优化用户体验，北京格鑫科技有限公司根据现行法规及政策，制定本《柚选兼职个人信息保护政策》。 本《个人信息保护政策》将详细说明柚选兼职（包括柚选兼职旗下所有产品）在获取、管理及保护用户个人信息方面的政策及措施。本《个人信息保护政策》适用于柚选兼职（包括柚选兼职旗下所有产品）向您提供的所有服务。<br> <br>个人信息的收集<br> <br>您已知悉且同意，在您注册柚选兼职（包括柚选兼职旗下所有产品）帐号或使用柚选兼职（包括柚选兼职旗下所有产品）提供的服务时，柚选兼职（包括柚选兼职旗下所有产品）将记录您提供的相关个人信息，如：姓名、手机号码等，上述个人信息是您获得柚选兼职（包括柚选兼职旗下所有产品）提供服务的基础。同时，基于优化用户体验之目的，柚选兼职（包括柚选兼职旗下所有产品）会获取与提升柚选兼职（包括柚选兼职旗下所有产品）服务有关的其他信息，例如当您访问柚选兼职（包括柚选兼职旗下所有产品）时，我们可能会收集哪些服务的受欢迎程度信息等以便优化我们的服务。<br> <br>个人信息的管理<br> <br>为了向您提供更好的服务或产品，柚选兼职（包括柚选兼职旗下所有产品）会在下述情形使用您的个人信息：<br> <br>根据相关法律法规的要求；<br> <br>根据您的授权；<br> <br>3）根据柚选兼职（包括柚选兼职旗下所有产品）相关服务条款、应用许可使用协议的约定。<br> <br>此外，您已知悉并同意：在现行法律法规允许的范围内，柚选兼职（包括柚选兼职旗下所有产品）可能会将您非隐私的个人信息用于市场营销，使用方式包括但不限于：向您通告或推荐柚选兼职（包括柚选兼职旗下所有产品）的服务或产品信息，以及其他此类根据您使用柚选兼职（包括柚选兼职旗下所有产品）服务或产品的情况所认为您可能会感兴趣的信息。其中也包括您在采取授权等某动作时选择分享的信息。<br> <br>未经您本人允许，柚选兼职（包括柚选兼职旗下所有产品）不会向任何第三方披露您的个人信息，下列情形除外：<br> <br>柚选兼职（包括柚选兼职旗下所有产品）已经取得您或您监护人的授权；<br> <br>司法机关或行政机关给予法定程序要求柚选兼职（包括柚选兼职旗下所有产品）披露的；<br> <br>柚选兼职（包括柚选兼职旗下所有产品）为维护自身合法权益而向用户提起诉讼或仲裁时；<br> <br>根据您与柚选兼职（包括柚选兼职旗下所有产品）相关服务条款、应用许可使用协议的约定；<br> <br>5）法律法规规定的其他情形。<br> <br>个人信息的保护<br> <br>柚选兼职（包括柚选兼职旗下所有产品）将尽一切合理努力保护其获得的用户个人信息。为防止用户个人信息在意外的、未经授权的情况下被非法访问、复制、修改、传送、遗失、破坏、处理或使用，柚选兼职（包括柚选兼职旗下所有产品）已经并将继续采取以下措施保护您的个人信息：<br> <br>以适当的方式对用户的个人信息进行加密处理；<br> <br>在适当的位置使用密码对用户个人信息进行保护；<br> <br>限制对用户个人信息的访问；<br> <br>其他的合理措施。<br> <br>尽管已经采取了上述合理有效措施，并已经遵守了相关法律规定要求的标准，但柚选兼职（包括柚选兼职旗下所有产品）仍然无法保证您的个人信息通过不安全途径进行交流时的安全性。因此，用户个人应采取积极措施保证个人信息的安全，如：定期修改帐号密码，不将自己的帐号密码等个人信息透露给他人。<br> <br>您知悉：柚选兼职（包括柚选兼职旗下所有产品）提供的个人信息保护措施仅适用于柚选兼职（包括柚选兼职旗下所有产品）平台，一旦您离开柚选兼职（包括柚选兼职旗下所有产品），浏览或使用其他网站、服务及内容资源，柚选兼职（包括柚选兼职旗下所有产品）即没有能力及义务保护您在柚选兼职（包括柚选兼职旗下所有产品）以外的网站提交的任何个人信息，无论您登录或浏览上述网站是否基于柚选兼职（包括柚选兼职旗下所有产品）的链接或引导。<br> <br>链接<br> <br>柚选兼职（包括柚选兼职旗下所有产品）应用内可能包含其他网站链接。对于我们的网站所链接至网站所采用的隐私政策或其他做法，以及其他网站上含有的信息或内容，柚选兼职（包括柚选兼职旗下所有产品）概不负责。本隐私声明仅适用于本应用收集的信息。<br> <br>修订<br> <br>北京格鑫科技有限公司会对隐私政策进行修改。如果您选择继续使用我们的服务，即表示您接受这些修改。<br> <br>其他<br>如果您还有其他问题和建议，请通过应用内用户反馈联系我们。<br>档铺网——在线文档免费处理</p>";
    
    self.talbleV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) style:UITableViewStylePlain];
    self.talbleV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.talbleV.delegate = self;
    self.talbleV.dataSource = self;
    [self.view addSubview:self.talbleV];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    self.navigationController.navigationBar.translucent = NO;
//
//    [self.navigationController.navigationBar setBarTintColor:kColor_Main];
//    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
    
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"turnleft"] forState:UIControlStateNormal];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[ECUtil colorWithHexString:@"4a4a4a"],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.praStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    cell.textLabel.attributedText = attributedString;
    cell.textLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.praStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(KSCREEN_WIDTH - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    return rect.size.height;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
