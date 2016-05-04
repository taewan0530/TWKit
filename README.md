# TWKit

[![CI Status](http://img.shields.io/travis/Keun young Kim/TWKit.svg?style=flat)](https://travis-ci.org/Keun young Kim/TWKit)
[![Version](https://img.shields.io/cocoapods/v/TWKit.svg?style=flat)](http://cocoapods.org/pods/TWKit)
[![License](https://img.shields.io/cocoapods/l/TWKit.svg?style=flat)](http://cocoapods.org/pods/TWKit)
[![Platform](https://img.shields.io/cocoapods/p/TWKit.svg?style=flat)](http://cocoapods.org/pods/TWKit)

## Installation

TWKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TWKit'
```

OR

```ruby
pod 'TWKit/EasyStyle'
pod 'TWKit/GetConstraint'
pod 'TWKit/AttributedString'
pod 'TWKit/KeyboardHelper'
pod 'TWKit/ObjectPool'
pod 'TWKit/StructObject'
pod 'TWKit/Extension'
pod 'TWKit/Function'
```


##EasyStyle

뷰에 디자인만 적용하기 위해 IBOutlet으로 코드와 연결하는것을 피하고 손쉽게 뷰에 스타일을 적용 하기위해서\n
'MGEStyles'를 swift로 바꾸고 동시에 여러 스타일을 적용할 수 있도록 개발.

```swift
let manger = EasyStyleManager.sharedInstance
manger.registerStyle("sample") { view in
    if let label = view as? UILabel {
        label.backgroundColor = UIColor.blueColor()
    }
}

manger.registerStyle("test") { view in
    if let label = view as? UILabel {
        label.textColor = UIColor.cyanColor()
    }
}
```

###Applying Styles

####By Interface Builder
인터페이스 빌더를 사용하면 IBOutlet을 사용할 필요가 없어서 좋다 :)

![](imgs/easystyle_01.png?raw=true)


####By Code

```swift
view.easyStyle = "test, sample"
```

####Result

![](imgs/easystyle_02.png?raw=true)




##GetConstraint

뷰와 코드를 IBOutlet으로 연결되어 많은 변수가 참조되는 것이 싫어서 개발
Left, Right 와 Leading, Trailing 다르다는것을 유의하고 사용


```swift
let topConstraint = view.getConstraint(attribute: .Top)
topConstraint?.constant = 20
```



##AttributedString

NSAttributedString에 쉽게 스타일을 적용할 수 있도록 개발

```swift
let text = "Label {sample} test message {icon} sample message {icon} Label"
let attributeString: NSAttributedString = text.toAttributedString([
    "Lab": [NSForegroundColorAttributeName : UIColor.brownColor()],
    "a": [NSBackgroundColorAttributeName : UIColor.purpleColor()],
    "{sample}": [TWKitUIImageAttributeName: UIImage(named: "sample")!],
    "{icon}": [TWKitUIImageAttributeName: UIImage(named: "icon")!]
])
label.attributedText = attributeString
```

//결과 화면 스샷으로 추가해주자.



##KeyboardHelper

스크롤뷰안에 TextField 가 있을때 쉽게 contentInset를 적용

```swift
let keyboardHelper = KeyboardHelper(scrollview)
```

//결과 화면 스샷으로 추가해주자.



##ObjectPool

객체 재사용 쉽게 하기위해 개발

```swift
let objPool = ObjectPool<UILabel> {
    return UILabel()
}

//객체 생성
for i in 0..<10 {
    let label = objPool.getInstance()    
}

//사용이 끝나면 objPool로 되돌려준다.
for label in objPool.activeList {
    objPool.returnInstance(label)
}
```



##StructObject

performSegueWithIdentifier(identifier:, sender:)에서 struct를 sender에 넣고 싶을때 사용!

```swift
let struct = StructObject(CGRectMake(0,0,10,10))
let rect = StructObject<CGRect>.from(struct)
print("StructObject as CGRect is: \(rect)")
```



##Extension

Array사용시에 옵셔널로 쉽게 사용.

```swift
let arr = ["test","sample"]

arr[2] //Error
arr[safe: 2] //nil
```








## Author

taewankim, taewan0530@daum.net

## License

MIT


### References

Inspired by projects: 
- https://github.com/ManueGE/MGEStyles
- https://github.com/dzog/ImgGlyph
- http://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings#answer-30593673
- http://ufx.kr/blog/591