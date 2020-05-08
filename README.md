# rn-mta

## MTA版本

- iOS SDK version 2.6.0
- Android SDK version 3.4.7

#### 此项目基于 [yyyyu/react-native-mta](https://github.com/yyyyu/react-native-mta)，升级 ios SDK 至最新2.6.0。[更新说明](http://mta.qq.com/docs/release_note_SDK.html)

## 安装

```bash
yarn add rnmta
```

or

```bash
npm install --save rnmta
```

## 配置

### ios

#### 1. 自动配置(推荐)

```bash
cd ios && pod install
```

### android

#### 额外配置

在 android/app/build.gradle 文件默认配置部分添加如下参数，此部分可以通过代码动态覆盖，gradle 同步时不添加则会出错无法编译

```Groovy
android {
    defaultConfig {
    	// add this
        manifestPlaceholders = [
            MTA_APPKEY: "",
            MTA_CHANNEL: ""
        ]
    }
}
```


## JS API

```javascript
import mta from 'rnmta'

mta.startWithAppkey({ appKey: 'appKey' })
  .then(res => { console.log(res) })
  .catch(err => { console.error(err) })
```

### 参数说明

1. 参数注释带有 optional 字样为可选参数，括号内为默认值，e.g. optional('default')
2. iosOnly androidOnly 表示只有在相应平台才会生效
3. 事件类型接口参数值只支持字符串(sdk 限制: **目前单个参数值最长支持64位，请您控制参数值长度，不建议上传URL；支持类型为字符串类型，暂不支持其他类型。**)

### 返回值说明

1. 所有函数均以 es7 async 形式创建
2. 如果库未初始化，调用函数会抛出初始化失败异常错误
3. 除 CustomEvent 系列函数有精确错误描述(原生 SDK 提供错误信息)外，其余函数均以返回 boolean 表示调用成功或失败，由于上报与业务逻辑联系不紧密，所以即便调用失败情况下也不会抛出异常，避免未处理错误导致应用不必要的闪退
4. 返回类型
   - Boolean
   - Object

     ```javascript
     { errCode: 0, errMsg: '' }
     { errCode: -1, errMsg: 'MTA初始化未成功' }
     { errCode: -2, errMsg: 'MTA传入参数错误' }
     { errCode: -3, errMsg: 'MTA传入参数过长' }
     { errCode: -9, errMsg: '未知错误' }
     ```

#### startWithAppkey 初始化 MTA 模块

```javascript
mta.startWithAppkey({
  appKey: 'you app key', // mta 管理后台中拿到的 appKey(*ios android 不同*)
  channel: 'channel',    // androidOnly optional('')
  isDebug: false,        // androidOnly optional(false)
})
```

#### trackPageBegin 跟踪页面打开

```javascript
mta.trackPageBegin({
  page: 'page_id',      // 页面标识
  appKey: 'you app key' // iosOnly optional(初始化 appKey)
})
```

#### trackPageEnd 跟踪页面关闭

```javascript
mta.trackPageEnd({
  page: 'page_id',       // 跟踪页面标识
  appKey: 'you app key', // iosOnly optional(初始化 appKey)
  isRealTime: false      // iosOnly optional(false) 是否实时上报数据
})
```

#### trackCustomEvent 自定义事件

```javascript
mta.trackCustomEvent({
  event: 'event_id',     // 事件标识
  params: {},            // optional({}) 事件参数
  appKey: 'you app key', // iosOnly optional(初始化 appKey)
  isRealTime: false      // iosOnly optional(false) 是否实时上报数据
})
```

#### trackCustomEventBegin 自定义事件开始

```javascript
mta.trackCustomEventBegin({
  event: 'event_id',     // 事件标识
  params: {},            // optional({}) 事件参数
  appKey: 'you app key', // iosOnly optional(初始化 appKey)
  isRealTime: false      // iosOnly optional(false) 是否实时上报数据
})
```

#### trackCustomEventEnd 自定义事件结束

```javascript
mta.trackCustomEventEnd({
  event: 'event_id',     // 事件标识
  params: {},            // optional({}) 事件参数
  appKey: 'you app key', // iosOnly optional(初始化 appKey)
  isRealTime: false      // iosOnly optional(false) 是否实时上报数据
})
```

#### trackCustomEventDuration 持续一段时间的自定义事件

```javascript
mta.trackCustomEventDuration({
  event: 'event_id',     // 事件标识
  duration: 1000,        // 事件持续时间
  params: {},            // optional({}) 事件参数
  appKey: 'you app key', // iosOnly optional(初始化 appKey)
  isRealTime: false      // iosOnly optional(false) 是否实时上报数据
})
```

#### trackActiveBegin 跟踪应用进入前台

```javascript
mta.trackActiveBegin() // iosOnly
```

#### trackActiveEnd 跟踪应用进入后台

```javascript
mta.trackActiveEnd() // iosOnly
```

#### setUserProperty 设置自定义参数

```javascript
mta.setUserProperty({ customKey: 'customValue' })
```