import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State inputText: string = '';
  @State errorMessage: string = '';
  
  // 验证是否为10位数字（只检查长度，不验证数字是否正确）
  validateInput(): boolean {
    return this.inputText.length === 10;
  }
  
  // 处理确认按钮点击 - 跳转到视频播放页面
  handleConfirm() {
    if (this.validateInput()) {
      this.errorMessage = '';
      
      // 跳转到视频播放页面，传递验证状态
      router.pushUrl({
        url: 'pages/VideoPage',
        params: {
          inputValid: true
        }
      });
    } else {
      this.errorMessage = '请输入10位QQ号码';
    }
  }
  
  // 处理输入变化
  handleInputChange(value: string) {
    // 只允许数字输入
    const numericValue = value.replace(/[^\d]/g, '');
    // 限制最大长度为10
    if (numericValue.length <= 10) {
      this.inputText = numericValue;
    }
  }
  
  build() {
    Column() {
      // 标题
      Text('QQTI分析系统')
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 60, bottom: 30 })
        .fontColor('#1A73E8')
      
      // 输入区域
      Column({ space: 20 }) {
        // 输入提示
        Text('请输入您的QQ号（不足10位后面补0）')
          .fontSize(22)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 20 })
        
        // 输入框
        TextInput({ placeholder: '请输入10位QQ号码', text: this.inputText })
          .placeholderColor('#999999')
          .placeholderFont({ size: 18 })
          .fontSize(22)
          .fontColor(Color.Black)
          .backgroundColor('#F8F9FA')
          .borderRadius(12)
          .border({ width: 1, color: '#E0E0E0' })
          .padding({ left: 20, right: 20, top: 15, bottom: 15 })
          .margin({ bottom: 15 })
          .width('85%')
          .maxLength(10)
          .type(InputType.Number)
          .onChange((value: string) => {
            this.handleInputChange(value);
          })
        
        // 当前输入长度显示
        Row({ space: 10 }) {
          Text('当前长度:')
            .fontSize(16)
            .fontColor('#666666')
          
          Text(this.inputText.length.toString())
            .fontSize(16)
            .fontColor(this.inputText.length === 10 ? '#34C759' : '#FF9500')
            .fontWeight(FontWeight.Bold)
          
          Text('/10')
            .fontSize(16)
            .fontColor('#666666')
        }
        .margin({ bottom: 10 })
        
        // 错误信息显示
        if (this.errorMessage) {
          Row({ space: 8 }) {
            Text('⚠️')
              .fontSize(16)
            
            Text(this.errorMessage)
              .fontSize(16)
              .fontColor(Color.Red)
          }
          .margin({ bottom: 15 })
          .justifyContent(FlexAlign.Center)
        }
        
        // 分析按钮
        Button('开始人格分析', { type: ButtonType.Capsule })
          .width(220)
          .height(55)
          .fontSize(20)
          .fontColor(Color.White)
          .backgroundColor(this.inputText.length === 10 ? '#1A73E8' : '#CCCCCC')
          .margin({ top: 15, bottom: 20 })
          .enabled(this.inputText.length === 10)
          .onClick(() => {
            this.handleConfirm();
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      
      // 测试说明
      Column({ space: 10 }) {
        Text('📊 测试说明')
          .fontSize(20)
          .fontColor('#1A73E8')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 10 })
        
        Text('1. 请输入您的10位QQ号码进行人格类型分析')
          .fontSize(14)
          .fontColor('#666666')
          .textAlign(TextAlign.Start)
          .width('90%')
        
        Text('2. 系统将根据QQ号分析您的性格特点')
          .fontSize(14)
          .fontColor('#666666')
          .textAlign(TextAlign.Start)
          .width('90%')
        
        Text('3. 测试结果仅供娱乐参考')
          .fontSize(14)
          .fontColor('#666666')
          .textAlign(TextAlign.Start)
          .width('90%')
        
        Text('4. 如有雷同阿哈全责')
          .fontSize(14)
          .fontColor('#666666')
          .textAlign(TextAlign.Start)
          .width('90%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 40 })
      .padding({ top: 20, bottom: 20, left: 15, right: 15 })
      .backgroundColor('#E8F4FD')
      .borderRadius(12)
      .margin({ left: 20, right: 20 })
      
      // 底部提示
      Column() {
        Text('🎯')
          .fontSize(50)
          .margin({ bottom: 15 })
          .opacity(0.7)
        
        Text('基于QQ号的人格类型分析系统')
          .fontSize(18)
          .fontColor('#1A73E8')
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)
          .margin({ bottom: 8 })
        
        Text('通过算法分析QQ号数字特征，揭示性格特点')
          .fontSize(14)
          .fontColor('#666666')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 5 })
        
        Text('分析结果将以个性化视频形式呈现')
          .fontSize(14)
          .fontColor('#999999')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(180)
      .justifyContent(FlexAlign.Center)
      .margin({ top: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding({ left: 20, right: 20 })
  }
}