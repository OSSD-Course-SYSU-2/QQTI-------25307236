import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct VideoPage {
  // 接收从Index页面传递的参数
  @State inputValid: boolean = false;
  @State isPlaying: boolean = true;
  
  // Video controller
  videoController: VideoController = new VideoController();
  
  // 页面参数
  private params: router.RouterOptions = router.getParams() as router.RouterOptions;
  
  aboutToAppear() {
    // 从路由参数中获取验证状态
    if (this.params && this.params['inputValid']) {
      this.inputValid = this.params['inputValid'] as boolean;
    }
    
    // 如果验证通过，自动开始播放视频
    if (this.inputValid) {
      setTimeout(() => {
        if (this.videoController) {
          this.videoController.start();
        }
      }, 300);
    }
  }
  
  // 处理视频播放完成
  handleVideoFinish() {
    this.isPlaying = false;
    console.info('');
  }
  
  // 返回输入页面
  goBack() {
    router.back();
  }
  
  build() {
    Column() {
      // 标题和返回按钮
      Row({ space: 20 }) {
        Button('←')
          .width(40)
          .height(40)
          .fontSize(20)
          .fontColor(Color.White)
          .backgroundColor('#007DFF')
          .borderRadius(20)
          .onClick(() => {
            this.goBack();
          })
        
        Text('网络安全反诈宣传')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D32F2F')
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .padding({ left: 20, top: 40, bottom: 30 })
      
      if (this.inputValid) {
        // 验证通过，显示视频播放器
        Column({ space: 15 }) {
          Text('你被骗了')
            .fontSize(22)
            .fontColor('#333333')
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 20 })
          
          Video({
            src: $rawfile('video.mp4'),
            controller: this.videoController
          })
            .width('95%')
            .height(350)
            .backgroundColor('#000000')
            .controls(true)
            .autoPlay(false)
            .loop(false)
            .muted(false)
            .onStart(() => {
              console.info('播放');
              this.isPlaying = true;
            })
            .onPause(() => {
              console.info('暂停');
              this.isPlaying = false;
            })
            .onFinish(() => {
              console.info('播放完成');
              this.handleVideoFinish();
            })
            .onError(() => {
              console.error('视频播放错误');
              promptAction.showToast({
                message: '反诈视频播放失败，请检查视频文件',
                duration: 3000
              });
            })
            .onPrepared((e) => {
              console.info('视频准备完成，时长：' + e.duration + '秒');
            })
          
          // 播放状态显示
          Row({ space: 10 }) {
            if (this.isPlaying) {
              Text('播放中...')
                .fontSize(18)
                .fontColor('#007DFF')
                .fontWeight(FontWeight.Medium)
            } else {
              Text('已暂停')
                .fontSize(18)
                .fontColor('#666666')
                .fontWeight(FontWeight.Medium)
            }
          }
          .margin({ top: 20 })
          .justifyContent(FlexAlign.Center)
          
          // 控制按钮
          Row({ space: 20 }) {
            Button('重新播放', { type: ButtonType.Normal })
              .width(120)
              .height(45)
              .fontSize(16)
              .backgroundColor('#34C759')
              .fontColor(Color.White)
              .borderRadius(8)
              .onClick(() => {
                this.videoController.setCurrentTime(0);
                this.videoController.start();
                this.isPlaying = true;
              })
            
            Button(this.isPlaying ? '暂停' : '继续', { type: ButtonType.Normal })
              .width(120)
              .height(45)
              .fontSize(16)
              .backgroundColor('#FF9500')
              .fontColor(Color.White)
              .borderRadius(8)
              .onClick(() => {
                if (this.isPlaying) {
                  this.videoController.pause();
                  this.isPlaying = false;
                } else {
                  this.videoController.start();
                  this.isPlaying = true;
                }
              })
          }
          .margin({ top: 25 })
          .justifyContent(FlexAlign.Center)
          
          // 提示信息
          Column({ space: 8 }) {
            Text('⚠️ 重要提醒：您刚刚输入了QQ号！')
              .fontSize(16)
              .fontColor('#D32F2F')
              .fontWeight(FontWeight.Bold)
            
            Text('在网络上随意输入个人信息存在安全风险')
              .fontSize(14)
              .fontColor('#666666')
              .textAlign(TextAlign.Center)
            
            Text('请提高安全意识')
              .fontSize(14)
              .fontColor('#666666')
              .textAlign(TextAlign.Center)
          }
          .margin({ top: 30, bottom: 10 })
          .width('90%')
          
          Text('视频内容：个人信息保护与反诈骗知识')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 5 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 20 })
      } else {
        // 验证未通过，显示错误信息
        Column({ space: 20 }) {
          Text('🔒')
            .fontSize(80)
            .margin({ bottom: 20 })
          
          Text('安全验证失败')
            .fontSize(26)
            .fontColor('#D32F2F')
            .fontWeight(FontWeight.Bold)
          
          Text('请输入完整的10位QQ号以继续')
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 10 })
          
          Text('这是为了保护您的个人信息安全')
            .fontSize(14)
            .fontColor('#999999')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 30 })
          
          Button('返回重新输入', { type: ButtonType.Capsule })
            .width(200)
            .height(50)
            .fontSize(18)
            .fontColor(Color.White)
            .backgroundColor('#1A73E8')
            .onClick(() => {
              this.goBack();
            })
        }
        .width('100%')
        .height('60%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}