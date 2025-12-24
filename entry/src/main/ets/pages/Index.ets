import { hilog } from '@kit.PerformanceAnalysisKit';

const DOMAIN = 0x0000;

interface HistoricalEvent {
  year: number;
  title: string;
  description: string;
}

// data base
class HistoricalEventsData {
  private static events: Map<string, HistoricalEvent[]> = new Map<string, HistoricalEvent[]>([
    // 1
    ['1-1', [
      { year: 2002, title: '欧元流通', description: '欧元在12个欧洲国家开始流通'} as HistoricalEvent
    ]],
    ['1-15', [
      { year: 2001, title: '维基百科', description: '维基百科正式上线'} as HistoricalEvent
    ]],
    ['1-27', [
      { year: 2010, title: 'iPad发布', description: '苹果公司发布第一代iPad'} as HistoricalEvent
    ]],

    // 2
    ['2-14', [
      { year: 1876, title: '电话发明', description: '亚历山大·贝尔获得电话专利'} as HistoricalEvent,
      { year: 1929, title: '情人节大屠杀', description: '芝加哥黑帮火拼事件'} as HistoricalEvent
    ]],
    ['2-24', [
      { year: 1955, title: '乔布斯诞生', description: '苹果公司联合创始人史蒂夫·乔布斯出生'} as HistoricalEvent,
      { year: 2022, title: '俄乌战争', description: '俄罗斯对乌克兰发动全面入侵'} as HistoricalEvent
    ]],

    // 3
    ['3-8', [
      { year: 1911, title: '国际妇女节', description: '首个国际劳动妇女节'} as HistoricalEvent
    ]],
    ['3-14', [
      { year: 1879, title: '爱因斯坦诞生', description: '物理学家阿尔伯特·爱因斯坦出生'} as HistoricalEvent,
      { year: 1995, title: 'IE浏览器', description: '微软发布Internet Explorer 1.0'} as HistoricalEvent
    ]],

    // 4
    ['4-12', [
      { year: 1961, title: '加加林太空飞行', description: '尤里·加加林成为第一个进入太空的人类'} as HistoricalEvent,
      { year: 1981, title: '哥伦比亚号', description: '哥伦比亚号航天飞机首次飞行'} as HistoricalEvent
    ]],

    // 5
    ['5-1', [
      { year: 1886, title: '国际劳动节', description: '芝加哥工人罢工，后成为国际劳动节起源'} as HistoricalEvent
    ]],
    ['5-8', [
      { year: 1945, title: '欧洲胜利日', description: '二战欧洲战场结束'} as HistoricalEvent
    ]],

    // 6
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

    // 7
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

    // 8
    ['8-6', [
      { year: 1945, title: '广岛原子弹', description: '美国在广岛投下原子弹'} as HistoricalEvent,
      { year: 1991, title: '万维网', description: '蒂姆·伯纳斯-李公开万维网'} as HistoricalEvent
    ]],
    ['8-15', [
      { year: 1945, title: '日本投降', description: '日本宣布无条件投降，二战结束'} as HistoricalEvent,
      { year: 1947, title: '印度独立', description: '印度脱离英国独立'} as HistoricalEvent
    ]],

    //9
    ['9-11', [
      { year: 2001, title: '911事件', description: '恐怖分子袭击世贸中心和五角大楼'} as HistoricalEvent
    ]],

    // 10
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

    // 11
    ['11-9', [
      { year: 1989, title: '柏林墙倒塌', description: '柏林墙倒塌，冷战象征结束' } as HistoricalEvent,
    ]],
    ['11-22', [
      { year: 1963, title: '肯尼迪遇刺', description: '美国总统约翰·肯尼迪在达拉斯遇刺'} as HistoricalEvent,
      { year: 2005, title: 'Xbox 360', description: '微软发布Xbox 360游戏机'} as HistoricalEvent
    ]],

    // 12
    ['12-10', [
      { year: 1948, title: '世界人权宣言', description: '联合国通过《世界人权宣言》'} as HistoricalEvent
    ]],

    ['12-24', [
      { year: 1818, title: '平安夜', description: '《平安夜》在奥地利首次演唱'} as HistoricalEvent,
      { year: 1968, title: '阿波罗8号', description: '阿波罗8号首次环绕月球飞行'} as HistoricalEvent,
      { year: 2025, title: '夜诗恋', description: '夜诗恋Felista当前的时间段'} as HistoricalEvent
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
    if (result !== undefined) {
      return result;
    } else {
      return [];
    }
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
  @State events: HistoricalEvent[] = [];
  @State selectedDate: Date = new Date();

  aboutToAppear(): void {
    this.loadTodayEvents();
  }

  loadTodayEvents(): void {
    const today = new Date();
    this.selectedDate = today;
    this.loadEventsForDate(today);
  }

  loadEventsForDate(date: Date): void {
    const options: Intl.DateTimeFormatOptions = {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      weekday: 'long'
    };
    this.currentDate = date.toLocaleDateString('zh-CN', options);
    const month = date.getMonth() + 1;
    const day = date.getDate();
    this.events = HistoricalEventsData.getEventsForDate(month, day);
  }

  changeDate(days: number): void {
    const newDate = new Date(this.selectedDate);
    newDate.setDate(newDate.getDate() + days);
    this.selectedDate = newDate;
    this.loadEventsForDate(newDate);
  }

  build() {
    Column() {
      this.HeaderSection()
      this.NavigationButtons()

      // history list
      if (this.events.length > 0) {
        this.EventsList()
      } else {
        this.NoEventsSection()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  HeaderSection() {
    Column() {
      Text('历史上的今天')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .margin({ bottom: 8 })

      Text(this.currentDate)
        .fontSize(16)
        .fontColor('#E0E0E0')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#1976D2')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  NavigationButtons() {
    Row() {
      Button('← 前一天')
        .onClick(() => this.changeDate(-1))
        .backgroundColor('#1565C0')
        .fontSize(14)
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })

      Button('今天')
        .onClick(() => {
          this.selectedDate = new Date();
          this.loadEventsForDate(this.selectedDate);
        })
        .backgroundColor('#0D47A1')
        .fontSize(14)
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .margin({ left: 8, right: 8 })

      Button('后一天 →')
        .onClick(() => this.changeDate(1))
        .backgroundColor('#1565C0')
        .fontSize(14)
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  EventsList() {
    List({ space: 12 }) {
      ForEach(this.events, (event: HistoricalEvent, index: number) => {
        ListItem() {
          this.EventCard(event, index)
        }
      }, (event: HistoricalEvent, index: number) => `${index}-${event.year}-${event.title}`)
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
  }

  @Builder
  EventCard(event: HistoricalEvent, index: number) {
    Column() {
      Row() {
        // year
        Column() {
          Text(event.year.toString())
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1976D2')

        }
        .width(80)
        .justifyContent(FlexAlign.Center)

        // contingut
        Column() {
          Text(event.title)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#212121')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(event.description)
            .fontSize(14)
            .fontColor('#757575')
            .margin({ top: 6 })
            .maxLines(3)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({
      radius: 8,
      color: '#15000000',
      offsetX: 0,
      offsetY: 2
    })
  }


  @Builder
  NoEventsSection() {
    Column() {
      Text('这一天没有记录')
        .fontSize(18)
        .fontColor('#757575')
        .margin({ bottom: 8 })

      Text('历史事件')
        .fontSize(14)
        .fontColor('#9E9E9E')
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
  }
}
