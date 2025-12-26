import { hilog } from '@kit.PerformanceAnalysisKit';
import { router } from '@kit.ArkUI';

const DOMAIN = 0x0000;

interface HistoricalEvent {
  year: number;
  title: string;
  description: string;
}

// 数据库类
class HistoricalEventsData {
  private static events: Map<string, HistoricalEvent[]> = new Map<string, HistoricalEvent[]>([
    // 1月
    ['1-1', [
      { year: 2002, title: '欧元流通', description: '欧元在12个欧洲国家开始流通'} as HistoricalEvent
    ]],
    ['1-15', [
      { year: 2001, title: '维基百科', description: '维基百科正式上线'} as HistoricalEvent
    ]],
    ['1-27', [
      { year: 2010, title: 'iPad发布', description: '苹果公司发布第一代iPad'} as HistoricalEvent
    ]],

    // 2月
    ['2-14', [
      { year: 1876, title: '电话发明', description: '亚历山大·贝尔获得电话专利'} as HistoricalEvent,
      { year: 1929, title: '情人节大屠杀', description: '芝加哥黑帮火拼事件'} as HistoricalEvent
    ]],
    ['2-24', [
      { year: 1955, title: '乔布斯诞生', description: '苹果公司联合创始人史蒂夫·乔布斯出生'} as HistoricalEvent,
      { year: 2022, title: '俄乌战争', description: '俄罗斯对乌克兰发动全面入侵'} as HistoricalEvent
    ]],

    // 3月
    ['3-8', [
      { year: 1911, title: '国际妇女节', description: '首个国际劳动妇女节'} as HistoricalEvent
    ]],
    ['3-14', [
      { year: 1879, title: '爱因斯坦诞生', description: '物理学家阿尔伯特·爱因斯坦出生'} as HistoricalEvent,
      { year: 1995, title: 'IE浏览器', description: '微软发布Internet Explorer 1.0'} as HistoricalEvent
    ]],

    // 4月
    ['4-12', [
      { year: 1961, title: '加加林太空飞行', description: '尤里·加加林成为第一个进入太空的人类'} as HistoricalEvent,
      { year: 1981, title: '哥伦比亚号', description: '哥伦比亚号航天飞机首次飞行'} as HistoricalEvent
    ]],

    // 5月
    ['5-1', [
      { year: 1886, title: '国际劳动节', description: '芝加哥工人罢工，后成为国际劳动节起源'} as HistoricalEvent
    ]],
    ['5-8', [
      { year: 1945, title: '欧洲胜利日', description: '二战欧洲战场结束'} as HistoricalEvent
    ]],

    // 6月
    ['6-4', [
      { year: 1989, title: '六四事件', description: '天安门广场学生运动遭到镇压'} as HistoricalEvent
    ]],
    ['6-5', [
      { year: 1967, title: '六日战争', description: '中东六日战争爆发'} as HistoricalEvent
    ]],
    ['6-28', [
      { year: 1914, title: '萨拉热窝事件', description: '斐迪南大公遇刺，引发第一次世界大战'} as HistoricalEvent,
      { year: 1969, title: '石墙骚乱', description: '石墙骚乱，LGBTQ+运动的起源'} as HistoricalEvent
    ]],

    // 7月
    ['7-1', [
      { year: 1997, title: '香港回归', description: '香港主权移交中华人民共和国'} as HistoricalEvent,
      { year: 1921, title: '中共成立', description: '中国共产党第一次全国代表大会召开'} as HistoricalEvent
    ]],
    ['7-4', [
      { year: 1776, title: '美国独立', description: '美国独立宣言发表'} as HistoricalEvent
    ]],
    ['7-20', [
      { year: 1969, title: '阿波罗11号', description: '阿姆斯特朗和奥尔德林登上月球'} as HistoricalEvent,
      { year: 1976, title: '海盗1号', description: '海盗1号探测器登陆火星'} as HistoricalEvent
    ]],

    // 8月
    ['8-6', [
      { year: 1945, title: '广岛原子弹', description: '美国在广岛投下原子弹'} as HistoricalEvent,
      { year: 1991, title: '万维网', description: '蒂姆·伯纳斯-李公开万维网'} as HistoricalEvent
    ]],
    ['8-15', [
      { year: 1945, title: '日本投降', description: '日本宣布无条件投降，二战结束'} as HistoricalEvent,
      { year: 1947, title: '印度独立', description: '印度脱离英国独立'} as HistoricalEvent
    ]],

    // 9月
    ['9-11', [
      { year: 2001, title: '911事件', description: '恐怖分子袭击世贸中心和五角大楼'} as HistoricalEvent
    ]],

    // 10月
    ['10-1', [
      { year: 1949, title: '中华人民共和国成立', description: '毛泽东在天安门宣布中华人民共和国成立'} as HistoricalEvent
    ]],
    ['10-4', [
      { year: 1957, title: '人造卫星1号', description: '苏联发射第一颗人造卫星'} as HistoricalEvent,
      { year: 2004, title: '太空船一号', description: '首次私人载人航天飞行'} as HistoricalEvent
    ]],
    ['10-12', [
      { year: 1492, title: '哥伦布到达美洲', description: '克里斯托弗·哥伦布到达美洲大陆'} as HistoricalEvent
    ]],

    // 11月
    ['11-9', [
      { year: 1989, title: '柏林墙倒塌', description: '柏林墙倒塌，冷战象征结束' } as HistoricalEvent
    ]],
    ['11-22', [
      { year: 1963, title: '肯尼迪遇刺', description: '美国总统约翰·肯尼迪在达拉斯遇刺'} as HistoricalEvent,
      { year: 2005, title: 'Xbox 360', description: '微软发布Xbox 360游戏机'} as HistoricalEvent
    ]],

    // 12月
    ['12-10', [
      { year: 1948, title: '世界人权宣言', description: '联合国通过《世界人权宣言》'} as HistoricalEvent
    ]],
    ['12-24', [
      { year: 1818, title: '平安夜', description: '《平安夜》在奥地利首次演唱'} as HistoricalEvent,
      { year: 1968, title: '阿波罗8号', description: '阿波罗8号首次环绕月球飞行'} as HistoricalEvent,
      { year: 2024, title: '圣诞前夜', description: '圣诞节前夕'} as HistoricalEvent
    ]],
    ['12-25', [
      { year: 1642, title: '牛顿诞生', description: '物理学家艾萨克·牛顿出生'} as HistoricalEvent,
      { year: 1991, title: '苏联解体', description: '苏联正式解体'} as HistoricalEvent
    ]],
    ['12-31', [
      { year: 1879, title: '爱迪生演示电灯', description: '托马斯·爱迪生公开演示白炽灯泡'} as HistoricalEvent
    ]],
  ]);

  static getEventsForDate(month: number, day: number): HistoricalEvent[] {
    const key = `${month}-${day}`;
    const result = HistoricalEventsData.events.get(key);
    return result !== undefined ? result : [];
  }

  static getTodayEvents(): HistoricalEvent[] {
    const today = new Date();
    return HistoricalEventsData.getEventsForDate(today.getMonth() + 1, today.getDate());
  }
}

@Entry
@Component
struct Index {
  @State currentDate: string = '';
  @State featuredEvent: HistoricalEvent | null = null;
  @State totalEventsCount: number = 0;

  aboutToAppear(): void {
    // log
    hilog.info(DOMAIN, 'testTag', '===== 应用开始 =====');

    this.loadTodayEvent();

    hilog.info(DOMAIN, 'testTag', '当前日期: %{public}s', this.currentDate);
    hilog.info(DOMAIN, 'testTag', '事件数量: %{public}d', this.totalEventsCount);

    if (this.featuredEvent !== null) {
      hilog.info(DOMAIN, 'testTag', '精选事件: %{public}s', this.featuredEvent.title);
    } else {
      hilog.info(DOMAIN, 'testTag', '今天没有事件');
    }

    hilog.info(DOMAIN, 'testTag', '===== 加载完成 =====');
  }

  loadTodayEvent(): void {
    const today = new Date();
    const options: Intl.DateTimeFormatOptions = {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      weekday: 'long'
    };

    this.currentDate = today.toLocaleDateString('zh-CN', options);
    const events = HistoricalEventsData.getTodayEvents();
    this.totalEventsCount = events.length;

    if (events.length > 0) {
      this.featuredEvent = events[0];
    } else {
      this.featuredEvent = null;
    }

    hilog.info(DOMAIN, 'testTag', '加载了 %{public}d 个事件', this.totalEventsCount);
  }

  goToDetailPage(): void {
    router.pushUrl({
      url: 'pages/HistoryDetail'
    }).catch((err: Error) => {
      hilog.error(DOMAIN, 'testTag', '跳转失败: %{public}s', err.message);
    });
  }

  build() {
    Column() {
      // 顶部标题
      Column() {
        Text('历史上的今天')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .margin({ bottom: 12 })

        Text(this.currentDate)
          .fontSize(16)
          .fontColor('#E0E0E0')
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#1976D2')
      .alignItems(HorizontalAlign.Start)

      // 主内容
      if (this.featuredEvent !== null) {
        Column() {
          // 精选标签
          Text('📌 今日精选')
            .fontSize(14)
            .fontColor('#1976D2')
            .fontWeight(FontWeight.Medium)
            .margin({ top: 32, bottom: 16 })

          // 事件卡片
          Column() {
            Text(this.featuredEvent.year.toString())
              .fontSize(72)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1976D2')
              .margin({ bottom: 24 })

            Text(this.featuredEvent.title)
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor('#212121')
              .textAlign(TextAlign.Center)
              .width('100%')
          }
          .width('85%')
          .padding(40)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
          .shadow({
            radius: 16,
            color: '#25000000',
            offsetX: 0,
            offsetY: 6
          })

          // 更多按钮
          Button() {
            Row() {
              Text('查看更多')
                .fontSize(16)
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Medium)

              if (this.totalEventsCount > 1) {
                Text(` (还有${this.totalEventsCount - 1}个事件)`)
                  .fontSize(14)
                  .fontColor('#E0E0E0')
              }
            }
          }
          .width('85%')
          .height(56)
          .backgroundColor('#1976D2')
          .borderRadius(12)
          .margin({ top: 32 })
          .onClick(() => this.goToDetailPage())
        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      } else {
        // 没有事件
        Column() {
          Text('📅')
            .fontSize(80)
            .margin({ bottom: 24 })

          Text('今天没有记录历史事件')
            .fontSize(20)
            .fontColor('#757575')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
