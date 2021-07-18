#  利用 didSet 實現反應式編程

### 參考
- [台灣社交 App](https://github.com/ailabstw/social-distancing-ios)
- [Wiki 反應式編程](https://zh.wikipedia.org/wiki/%E5%93%8D%E5%BA%94%E5%BC%8F%E7%BC%96%E7%A8%8B)
- [30 天了解 Swift 的 Combine](https://ithelp.ithome.com.tw/articles/10219418)


### File：
Observed.swift - @propertyWrapper 用以包裝需要觀察的任何型別，在資料變更後執行註冊時傳入的 _closure 

 ##### public init(wrappedValue: T, queue: DispatchQueue? = nil) 
- wrappedValue: 型別初始值
- queue: 執行閉包時的 thread ，預設為 nil 由系統分配。

##### public func callAsFunction(using block: @escaping (T) -> Void) 
- 註冊並傳入需要執行的必包
- 理解: NotificationCenter addObserved 

#####  public func cancel()
- 形同取消觀察所需執行的必包


### DataModel

##### Blog
- id: String 
- count: Int
- toggle: Bool 

畫面階層:
ViewController > tableView > Cell 
主標籤: 顯示 id 
點擊 Cell 切換 toggle 狀態變更顏色
點擊 + - : 更改 count 變反應在 Cell 上的數字標籤


### ViewController

##### OldViewController
```
MVVM 架構 - 命令式編成方式
ViewModel: 作為 ViewController 與 Model 橋樑
Model:  與 APIManager Model 溝通 處理 API Request

API  Request 處理結束 透過 delegate 回傳更新畫面命令
```

##### WithDataMethodViewController
```
 MVC 架構 - 命令式編成方式
 model: 處理 Data 相關處理 ，直接與VC 溝通
 DataModel: 自帶部分 API Request 處理Method
 API  Request 處理結束 透過 delegate 回傳更新畫面命令
```

##### ObserverdViewController
```
ObservedBoardCell ViewModel
利用 didSet 實現反應式編成，實現與 CurrentValueSubject 類似的觀察模式。
參考文章 [30 天了解 Swift 的 Combine] (https://developer.apple.com/documentation/combine/currentvaluesubject) Apple SDK [CurrentValueSubject](https://developer.apple.com/documentation/combine/currentvaluesubject)

```
