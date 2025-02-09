# ThemeKit适配深色模式介绍
## 目录
1. 简介
2. 使用方法
3. 工作原理
4. 注意事项

## 简介
ThemeKit是一款纯Swift开发，支持OC和Swift调用的iOS多主题解决方案。相比起Apple官方的Dark Mode适配，ThemeKit没有iOS 13的系统限制，用户在接入后可选择跟随系统主题切换，也可以手动控制应用主题。并且除颜色、图片等UI资源外，ThemeKit还可对字体（UIFont），字号（CGFloat），字符串（String）等元素进行类似的各主题下映射。
ThemeKit将各个类型的UI资源抽象为一个个Token和对应主题下值的映射（注册），集中收口进行维护和管理。在界面开发（使用）时，只需通过Token调用即可，而不需要关心每个资源在不同主题下的具体值。

下图是ThemeKit相较于目前流行的主题色方案的对比：
![image](https://github.com/user-attachments/assets/fac202b4-0dbe-47e9-b29e-751ce670697b)



## 使用方法
1. podfile、podspec中引入ThemeKit，代码文件中‘import ThemeKit’
2. 根据业务需要，自定义token以及对应主题下色值（图片、字体同理）
![image](https://github.com/user-attachments/assets/ffa2789e-a916-4547-aed4-0fc50c4c1a79)

![image](https://github.com/user-attachments/assets/1995b3ff-3f2a-4aa9-9463-5b0d5289372b)

3. 在业务中需要UI赋值的地方使用token，对绝对色值、图片进行替换即可，ThemeKit会根据当前主题返回对应的资源，当主题切换时重新更新UIView
```
let view = UIView()
let label = UILabel()
let button = UIButton(type: .custom)

// Before
view.backgroundColor = UIColor.white
label.textColor = UIColor(red: 153.0 / 255, green: 153.0 / 255, blue: 153.0 / 255, alpha: 1)
button.setTitleColor(UIColor(hex: 0xFD7443), for: .highlighted)
button.layer.borderColor = UIColor(hex: 0xEEEEEE).cgColor
let imageView = UIImageView(image: UIImage(named:"custom_image"))

// Now
view.backgroundColor = UIColor.common_bg2_color
label.textColor = UIColor.common_level3_color
button.setTitleColor(UIColor.common_orange1_color, for: .highlighted)
button.layer.borderColor = CGColor.common_line2_color
let imageView = UIImageView(image: DTheme.image.icon_single_calendar_busy(color: .common_level2_color, size: CGSize(width: 60, height: 60)))
```
4. 工程中若存在颜色不是直接赋值给UIView相关属性（参考'ThemeKit'中'UIKit+Theme'文件），则需要手动添加通知，并在App的外观变更后override自定义实现其updateTheme方法。例如，给UIButton针对不同state设置背景色、给CAGradientLayer设置渐变色数组colors…
![image](https://github.com/user-attachments/assets/3bc102dc-4ae3-4920-998e-563fdbe8c42d)


## 工作原理 —— 关联对象 + 方法交换
工程整体架构分层如下：
![image](https://github.com/user-attachments/assets/68288ea2-7f82-4a4b-92ff-d401cbf980c4)


* **UI选择器 ThemePicker:** 负责传入某个UI属性（Color，Font，Image）在深浅模式下的具体值，以及当主题切换时选择的对应逻辑
![image](https://github.com/user-attachments/assets/6e189578-ea88-4f44-954f-9f1ba3a348a3)

![image](https://github.com/user-attachments/assets/49d42694-5f58-46df-bede-3058116e5a57)

* **UIColor + themePicker:** 给UIColor（同样适用于UIImage、UIFont…）拓展ThemeColorPicker关联对象，在资源库中初始化“语义颜色”时一并初始化其themePicker属性
![image](https://github.com/user-attachments/assets/290e3a71-f6ef-41dc-a10e-aefeeb6c1cc7)

![image](https://github.com/user-attachments/assets/af6eb7e2-7d4b-49fa-a22d-19c26981fdf8)

* **NSObject + themePickers:** 给NSObject设置 [String:ThemePicker] 类型关联对象，其中的Key值是相关属性的赋值语句，用于后续调用Selector在深浅模式切换后perform相关方法
![image](https://github.com/user-attachments/assets/3f26f649-94fa-455a-aea2-65caee932044)

![image](https://github.com/user-attachments/assets/bea6a6e0-ac09-497c-9264-3b02c46f2465)

* **UIKit + MethodSwizzling:** 对UI组件(包括UIView、CALayer)中涉及到Color、Image、Font属性的set方法做方法交换，将themePicker绑定到对应控件的themePickers字典中，并添加ThemeUpdateNotification监听应用深浅模式切换
![image](https://github.com/user-attachments/assets/479d8927-1832-43ab-9168-a6eaf1433e66)

* **ThemeManager:** ThemeKit的核心管理类，其主要作用分两个方面
    1. 负责监听并执行由iOS系统或用户触发的主题切换操作，全局管理应用主题；
    ![image](https://github.com/user-attachments/assets/1185256b-2a43-4dc1-a687-cee03de0334d)

    2. 提供方法，各个ThemePicker传入各主题下元素，Manager返回当前主题下对应值；
    ![image](https://github.com/user-attachments/assets/1b25ee70-a8b8-45d5-9efc-1d89c4651b0a)


使用ThemeKit调用UI资源后，项目的UIView生效机制，以及当App深浅模式切换的时序图如下所示。此时对于业务方而言，ThemeKit是一个黑盒，无感知即可完成切换。

![image](https://github.com/user-attachments/assets/5fb4bac0-8577-454d-a9f6-3d298f887a81)

![image](https://github.com/user-attachments/assets/27290d2a-50e8-47e0-b00b-9e8491821817)


## 注意事项
* **NSAttributedString:** 一些NSAttributedString类型的UI属性，给其设置文字颜色时，动态颜色只是绑定在NSAttributedString上并没有绑定在UI控件上，所以第一次进入页面时渲染生效，但不具备实时刷新的能力
    **解决方法:** 
    1. 手动添加通知，override实现updateTheme方法，在外观变更后手动更新UI组件的NSAttributedString属性；
    2. 使用'DThemeKit'提供的API生成动态文字，并赋值给相关NSAttributedString属性；
* **UITableViewCell & UICollectionViewCell:** iOS给表格视图和集合视图的Cell设置了默认背景色——UIColor.systemBackground，该颜色会随着系统外观设置自动变化，因此需要手动将cell的背景色修改为资源库中的动态颜色


## Author

Zhang Yuf, zyf19990621@gmail.com

## License

ThemeKit is available under the MIT license. See the LICENSE file for more info.
