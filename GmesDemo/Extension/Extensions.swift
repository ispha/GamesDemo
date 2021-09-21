//
//  Extensions.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/19/21.
//
import UIKit
import QuartzCore
import MBProgressHUD

extension UIApplication {
	class func showLoader(_ animated: Bool = true) {
		DispatchQueue.main.async {
			guard let window = UIApplication.shared.windows.first else { return }

			MBProgressHUD.showAdded(to: window, animated: animated)
		}

	}

	class func hideLoader(_ animated: Bool = true) {
		DispatchQueue.main.async {
			guard let window = UIApplication.shared.windows.first else { return }
			MBProgressHUD.hide(for: window, animated: true)
		}
	}
}

extension FloatingPoint {
	var degreesToRadians: Self { return self * .pi / 180 }
	var radiansToDegrees: Self { return self * 180 / .pi }
}

extension CGPoint {
	// NOTE: bearing is in radians
	func locationWithBearing(bearing: Double, distanceMeters: Double) -> CGPoint {
		let distRadians = distanceMeters / (6372797.6) // earth radius in meters

		let origLat = Double(self.y.degreesToRadians)
		let origLon = Double(self.x.degreesToRadians)

		let newLat = asin(sin(origLat) * cos(distRadians) + cos(origLat) * sin(distRadians) * cos(bearing))
		let newLon = origLon + atan2(sin(bearing) * sin(distRadians) * cos(origLat), cos(distRadians) - sin(origLat) * sin(newLat))

		return CGPoint(x: newLon.radiansToDegrees, y: newLat.radiansToDegrees)
	}
}

@IBDesignable class DesignableButton: UIButton {
	@IBInspectable lazy var isRoundRectButton: Bool = false
	@IBInspectable public var borderColor: UIColor = UIColor.clear {
		didSet {
			self.layer.borderColor = borderColor.cgColor
		}
	}

	@IBInspectable public var borderWidth: CGFloat = 0.0 {
		didSet {
			self.layer.borderWidth = borderWidth
		}
	}

	//  MARK:   Awake From Nib
	override func awakeFromNib() {
		super.awakeFromNib()
		setUpView()
	}

	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setUpView()
	}

	@IBInspectable public var cornerRadius: CGFloat = 0.0 {
		didSet{
			setUpView()
		}
	}

	func setUpView() {
		if isRoundRectButton {
			self.layer.cornerRadius = self.bounds.height / 2
			self.clipsToBounds = true
		} else {
			self.layer.cornerRadius = self.cornerRadius
			self.clipsToBounds = true
		}
	}
}

@IBDesignable class DesignableUITextField: UITextField {
	override func awakeFromNib() {
		super.awakeFromNib()
		setUpView()
	}

	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setUpView()
	}

	// Provides left padding for images
	override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
		var textRect = super.rightViewRect(forBounds: bounds)
		textRect.origin.x -= rigthPadding
		return textRect
	}

	@IBInspectable var imageSelected: UIImage? {
		didSet {
			updateView()
		}
	}

	@IBInspectable lazy var isRoundRectButton : Bool = false
	@IBInspectable var rigthPadding: CGFloat = 5
	@IBInspectable var color: UIColor = HelpingMethods.colorWithHexString("828282") {
		didSet {
			updateView()
		}
	}

	func updateView() {
		leftView = nil
		rightView = nil
		if let image = imageSelected {
			rightViewMode = UITextField.ViewMode.never

			rightViewMode = UITextField.ViewMode.always
			let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
			imageView.contentMode = .scaleAspectFit
			imageView.image = image
			// Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
			imageView.tintColor = color
			rightView = imageView
		} else {
			rightViewMode = UITextField.ViewMode.never
			rightView = nil
		}
	}

	@IBInspectable public var cornerRadius : CGFloat = 0.0 {
		didSet {
			setUpView()
		}
	}

	func setUpView() {
		if isRoundRectButton {
			self.layer.cornerRadius = self.bounds.height / 2
			self.clipsToBounds = true
		} else {
			self.layer.cornerRadius = self.cornerRadius
			self.clipsToBounds = true
		}
	}
}

@IBDesignable class DesignableUITextView: UITextView {
	public override func awakeFromNib() {
		super.awakeFromNib()
		configureLabel()
	}

	public override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		configureLabel()
	}

	@IBInspectable var borderColor: UIColor = UIColor.white {
		willSet {
			layer.borderColor = newValue.cgColor
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = 5
		layer.masksToBounds = true
		layer.borderWidth = 1
		layer.borderColor = borderColor.cgColor
	}

	func configureLabel() {
		self.substituteFontName = self.font!.fontName
	}
}

@IBDesignable class DesignableUIImageView:UIImageView {
	@IBInspectable var rounded : Bool = true {

		didSet{

			makeRounded()

		}

	}



	func makeRounded(){

		if (rounded) {

			self.layer.cornerRadius = self.frame.size.height / 2.0
			self.layer.masksToBounds = true

			self.layer.borderColor = borderColor.cgColor
			self.layer.borderWidth = 1.0

		}

	}
	@IBInspectable public var borerWidth : CGFloat = 0.0 {
		didSet{
			layoutSubviews()
		}
	}
	@IBInspectable public var cornerRaduis : CGFloat = 0.0 {
		didSet{
			layoutSubviews()
		}
	}
	@IBInspectable var borderColor: UIColor = UIColor.white {
		willSet {
			layer.borderColor = newValue.cgColor
		}
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = rounded ?  self.frame.size.height / 2.0 : cornerRaduis
		layer.masksToBounds = true
		layer.borderWidth = borerWidth
		layer.borderColor = borderColor.cgColor
	}
}

@IBDesignable class DesignableUIView: UIView {
	@IBInspectable lazy var isRoundRectButton : Bool = false
	@IBInspectable public var cornerRadius : CGFloat = 0.0 {
		didSet{
			setUpView()
		}
	}

	@IBInspectable public var shadowColor : UIColor = UIColor.black {
		didSet {
			self.layer.shadowColor = shadowColor.cgColor
		}
	}
	@IBInspectable public var shadowOpacity : Float = 0.3 {
		didSet {
			self.layer.shadowOpacity = shadowOpacity
		}
	}
	@IBInspectable public var shadowOffset : CGSize = CGSize.zero {
		didSet {
			self.layer.shadowOffset = shadowOffset
		}
	}
	@IBInspectable public var shadowRadius : CGFloat = 1.0 {
		didSet {
			self.layer.shadowRadius = shadowRadius
		}
	}
	@IBInspectable public var borderColor : UIColor = UIColor.clear {
		didSet {
			self.layer.borderColor = borderColor.cgColor
		}
	}

	@IBInspectable public var borderWidth : CGFloat = 0.0 {
		didSet {
			self.layer.borderWidth = borderWidth
		}
	}

	//  MARK:   Awake From Nib
	override func awakeFromNib() {
		super.awakeFromNib()
		setUpView()
	}

	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setUpView()
	}

	func setUpView() {
		if isRoundRectButton {
			self.layer.cornerRadius = self.bounds.height/2;
			self.clipsToBounds = true
		} else {
			self.layer.cornerRadius = self.cornerRadius;
			self.clipsToBounds = true
		}
	}
}
extension String {
	func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
		return ceil(boundingBox.height)
	}
}

extension UIView {
	func shakeView(duration: CFTimeInterval = 2, pathLength: CGFloat = 15) {
		let position: CGPoint = self.center
		let path: UIBezierPath = UIBezierPath()
		path.move(to: CGPoint(x: position.x, y: position.y))
		path.addLine(to: CGPoint(x: position.x-pathLength, y: position.y))
		path.addLine(to: CGPoint(x: position.x-pathLength, y: position.y+pathLength))
		path.addLine(to: CGPoint(x: position.x+pathLength, y:  position.y+pathLength))
		path.addLine(  to: CGPoint(x: position.x+pathLength, y:  position.y-pathLength))
		path.addLine(to: CGPoint(x: position.x, y: position.y-pathLength))
		path.addLine(to: CGPoint(x: position.x, y: position.y))

		let positionAnimation = CAKeyframeAnimation(keyPath: "position")

		positionAnimation.path = path.cgPath
		positionAnimation.duration = duration
		positionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		CATransaction.begin()
		self.layer.add(positionAnimation, forKey: nil)
		CATransaction.commit()
	}
}

extension UITableViewCell {
	func shake(duration: CFTimeInterval = 2, pathLength: CGFloat = 15) {
		let position: CGPoint = self.center
		let path: UIBezierPath = UIBezierPath()
		path.move(to: CGPoint(x: position.x, y: position.y))
		path.addLine(to: CGPoint(x: position.x-pathLength, y: position.y))
		path.addLine(to: CGPoint(x: position.x-pathLength, y: position.y+pathLength))
		path.addLine(to: CGPoint(x: position.x+pathLength, y:  position.y+pathLength))
		path.addLine(  to: CGPoint(x: position.x+pathLength, y:  position.y-pathLength))
		path.addLine(to: CGPoint(x: position.x, y: position.y-pathLength))
		path.addLine(to: CGPoint(x: position.x, y: position.y))

		let positionAnimation = CAKeyframeAnimation(keyPath: "position")
		positionAnimation.path = path.cgPath
		positionAnimation.duration = duration
		positionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		CATransaction.begin()
		self.layer.add(positionAnimation, forKey: nil)
		CATransaction.commit()
	}
}

extension CustomStringConvertible {
	var description: String {
		let mirror = Mirror(reflecting: self)
		var result = ""
		for child in mirror.children {
			if let label = child.label {
				result += "\(label): \(child.value)"
			} else {
				result += "\(child.value)"
			}
		}
		return result
	}
}

extension NotificationCenter {
	func setObserver(observer: AnyObject, selector: Selector, name: String?, object: AnyObject?) {
		NotificationCenter.default.removeObserver(observer, name: name.map { NSNotification.Name(rawValue: $0) }, object: object)
		NotificationCenter.default.addObserver(observer, selector: selector, name: name.map { NSNotification.Name(rawValue: $0) }, object: object)
	}
}


extension UIApplication {
	class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
		if let navigationController = controller as? UINavigationController {
			return topViewController(controller: navigationController.visibleViewController)
		}
		if let tabController = controller as? UITabBarController {
			if let selected = tabController.selectedViewController {
				return topViewController(controller: selected)
			}
		}
		if let presented = controller?.presentedViewController {
			return topViewController(controller: presented)
		}
		return controller
	}
}

//MARK: Add Toast method function in UIView Extension so can use in whole project.
extension UIView {
	func showToast(toastMessage: String, duration: CGFloat, success: Bool, completion: @escaping () -> Void) {
		//View to blur bg and stopping user interaction
		let bgView = UIView(frame: self.frame)
		bgView.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(0.6))
		bgView.tag = 555

		//Label For showing toast text
		let lblMessage = UILabel()
		lblMessage.numberOfLines = 0
		lblMessage.lineBreakMode = .byWordWrapping
		lblMessage.textColor = .white
		if success {
			lblMessage.backgroundColor = HelpingMethods.colorWithHexString("009900")
		} else {
			lblMessage.backgroundColor = HelpingMethods.colorWithHexString("cc0000")
		}
		lblMessage.textAlignment = .center
		lblMessage.font = UIFont(name: "Helvetica Neue", size: 17)
		lblMessage.text = toastMessage

		//calculating toast label frame as per message content
		let maxSizeTitle : CGSize = CGSize(width: self.bounds.size.width-16, height: self.bounds.size.height)
		var expectedSizeTitle : CGSize = lblMessage.sizeThatFits(maxSizeTitle)
		// UILabel can return a size larger than the max size when the number of lines is 1
		expectedSizeTitle = CGSize(width:maxSizeTitle.width.getminimum(value2:expectedSizeTitle.width), height: maxSizeTitle.height.getminimum(value2:expectedSizeTitle.height))
		lblMessage.layer.cornerRadius = 8
		lblMessage.layer.masksToBounds = true
		bgView.addSubview(lblMessage)
		self.addSubview(bgView)
		lblMessage.alpha = 0
		UIView.animateKeyframes(withDuration:TimeInterval(duration) , delay: 0, options: [] , animations: {
			lblMessage.alpha = 1
		}, completion: {
			sucess in
			UIView.animate(withDuration:TimeInterval(duration), delay: 8, options: [] , animations: {
				lblMessage.alpha = 0
				bgView.alpha = 0
			})
			bgView.removeFromSuperview()
			completion()
		})
	}
}

extension CGFloat {
	func getminimum(value2: CGFloat) -> CGFloat {
		if self < value2 {
			return self
		} else {
			return value2
		}
	}
}

//MARK: Extension on UILabel for adding insets - for adding padding in top, bottom, right, left.
extension UIViewController {
	func hideKeyboardWhenTappedAround() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}

extension UIImageView {
	func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
		contentMode = mode
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else { return }
			DispatchQueue.main.async() {
				self.image = image
			}
		}.resume()
	}
	func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
		guard let url = URL(string: link) else { return }
		downloaded(from: url, contentMode: mode)
	}
}

extension UITextView {
	func adjustUITextViewHeight() {
		self.translatesAutoresizingMaskIntoConstraints = true
		self.sizeToFit()
		self.isScrollEnabled = false
	}
}
extension UIViewController {
	func transitionVc(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype) {
		let customVcTransition = vc
		let transition = CATransition()
		transition.duration = duration
		transition.type = CATransitionType.push
		transition.subtype = type
		vc.modalPresentationStyle = .overCurrentContext
		transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
		view.window!.layer.add(transition, forKey: kCATransition)
		present(customVcTransition, animated: false, completion: nil)
	}

	func dismissTransitionVc(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype) {
		let transition = CATransition()
		transition.duration = duration
		transition.type = CATransitionType.push
		transition.subtype = type
		transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
		view.window!.layer.add(transition, forKey: kCATransition)
		self.dismiss(animated: true, completion: {() in
			//UIApplication.topViewController()!.transitionVc(vc: vc, duration: 1, type: .fromRight)
		})
	}
}

// Using a function since `var image` might conflict with an existing variable
// (like on `UIImageView`)
extension UIView {
	func asImage() -> UIImage {
		let renderer = UIGraphicsImageRenderer(bounds: bounds)
		return renderer.image { rendererContext in
			layer.render(in: rendererContext.cgContext)
		}
	}
}

extension UIColor {
	func imageWithColor(width: CGFloat, height: CGFloat) -> UIImage {
		let size = CGSize(width: width, height: height)
		return UIGraphicsImageRenderer(size: size).image { rendererContext in
			self.setFill()
			rendererContext.fill(CGRect(origin: .zero, size: size))
		}
	}
}

extension UIView {
	func fadeIn(duration: TimeInterval = 1, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
		self.alpha = 0.0

		UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
			self.isHidden = false
			self.alpha = 1.0
		}, completion: completion)
	}

	func fadeOut(duration: TimeInterval = 1, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in

	}) {
		self.alpha = 1.0

		UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {

			self.alpha = 0.0

		}, completion: { _ in self.isHidden = true})
	}
}

extension UIPageViewController {
	 var isPagingEnabled: Bool {
		get {
		   var isEnabled: Bool = true
		   for view in view.subviews {
			   if let subView = view as? UIScrollView {
				   isEnabled = subView.isScrollEnabled
			   }
		   }
		   return isEnabled
	   } set {
		   for view in view.subviews {
			   if let subView = view as? UIScrollView {
				   subView.isScrollEnabled = newValue
			   }
		   }
	   }
   }
}

extension UILabel {
	public var substituteFontName : String {
		get {
			return self.font.fontName;
		} set {
			let fontNameToTest = self.font.fontName.lowercased()
			var fontName = newValue
			if fontNameToTest.range(of: "semibold") != nil {
				fontName += "-SemiBold"
			} else if fontNameToTest.range(of: "regular") != nil {
				fontName += "-Regular"
			} else if fontNameToTest.range(of: "bold") != nil {
				fontName += "-Bold"
			} else if fontNameToTest.range(of: "medium") != nil {
				fontName += "-Medium"
			} else if fontNameToTest.range(of: "light") != nil {
				fontName += "-Light"
			} else if fontNameToTest.range(of: "ultralight") != nil {
				fontName += "-UltraLight"
			}
		}
	}
}

extension UIButton {
	public var substituteFontName: String {
		get {
			return self.titleLabel!.font.fontName;
		} set {
			let fontNameToTest = self.titleLabel!.font.fontName.lowercased()
			var fontName = newValue
			if fontNameToTest.range(of: "semibold") != nil {
				fontName += "-SemiBold"
			} else if fontNameToTest.range(of: "regular") != nil {
				fontName += "-Regular"
			} else if fontNameToTest.range(of: "bold") != nil {
				fontName += "-Bold"
			} else if fontNameToTest.range(of: "medium") != nil {
				fontName += "-Medium"
			} else if fontNameToTest.range(of: "light") != nil {
				fontName += "-Light"
			} else if fontNameToTest.range(of: "ultralight") != nil {
				fontName += "-UltraLight"
			}
			self.titleLabel!.font = self.titleLabel?.font
		}
	}
}

extension UITextView {
	public var substituteFontName : String {
		get {
			return self.font?.fontName ?? ""
		} set {
			let fontNameToTest = self.font?.fontName.lowercased() ?? ""
			var fontName = newValue
			if fontNameToTest.range(of: "semibold") != nil {
				fontName += "-SemiBold"
			} else if fontNameToTest.range(of: "regular") != nil {
				fontName += "-Regular"
			} else if fontNameToTest.range(of: "bold") != nil {
				fontName += "-Bold"
			} else if fontNameToTest.range(of: "medium") != nil {
				fontName += "-Medium"
			} else if fontNameToTest.range(of: "light") != nil {
				fontName += "-Light"
			} else if fontNameToTest.range(of: "ultralight") != nil {
				fontName += "-UltraLight"
			}
			self.font = self.font! // UIFont(name: fontName, size:  UIDevice.current.userInterfaceIdiom == .phone ? self.font?.pointSize ?? 17 : (self.font?.pointSize ?? 17) + CGFloat(Constants.FONT_SIZE_CONSTANT_iPad))
		}
	}
}

extension UITextField {
	public var substituteFontName : String {
		get {
			return self.font?.fontName ?? ""
		} set {
			let fontNameToTest = self.font?.fontName.lowercased() ?? ""
			var fontName = newValue
			if fontNameToTest.range(of: "semibold") != nil {
				fontName += "-SemiBold"
			} else if fontNameToTest.range(of: "regular") != nil {
				fontName += "-Regular"
			} else if fontNameToTest.range(of: "bold") != nil {
				fontName += "-Bold"
			} else if fontNameToTest.range(of: "medium") != nil {
				fontName += "-Medium"
			} else if fontNameToTest.range(of: "light") != nil {
				fontName += "-Light"
			} else if fontNameToTest.range(of: "ultralight") != nil {
				fontName += "-UltraLight"
			}
			self.font = self.font!// UIFont(name: fontName, size: UIDevice.current.userInterfaceIdiom == .phone ? self.font?.pointSize ?? 17 : (self.font?.pointSize ?? 17) + CGFloat(Constants.FONT_SIZE_CONSTANT_iPad))
		}
	}
}



extension String {
	func convertToDictionary() -> [String: Any]? {
		if let data = self.data(using: .utf8) {
			do {
				return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
			} catch {
				print(error.localizedDescription)
			}
		}
		return nil
	}
}
extension UIDevice {
	static var isIphoneX: Bool {
		var modelIdentifier = ""
		if isSimulator {
			modelIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
		} else {
			var size = 0
			sysctlbyname("hw.machine", nil, &size, nil, 0)
			var machine = [CChar](repeating: 0, count: size)
			sysctlbyname("hw.machine", &machine, &size, nil, 0)
			modelIdentifier = String(cString: machine)
		}

		return modelIdentifier == "iPhone10,3" || modelIdentifier == "iPhone10,6"
	}

	static var isSimulator: Bool = TARGET_OS_SIMULATOR != 0
}
extension Array {
	func find(_ includedElement: (Element) -> Bool) -> Int? {
		for (idx, element) in self.enumerated() {
			if includedElement(element) {
				return idx
			}
		}
		return 0
	}
}
extension UIView {
	func shake(_ dur:Double) {
		let anim = CABasicAnimation(keyPath: "position")
		anim.duration = dur
		anim.repeatCount = 20
		anim.autoreverses = true
		anim.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
		anim.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
		self.layer.add(anim, forKey: "position")
	}
}
extension UIView {
func shake() {
	let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
	animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
	animation.duration = 0.6
	animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
	self.layer.add(animation, forKey: "shake")
}}

extension UIPageViewController {

	func enableSwipeGesture() {
		for view in self.view.subviews {
			if let subView = view as? UIScrollView {
				subView.isScrollEnabled = true
			}
		}
	}

	func disableSwipeGesture() {
	//	self.view.isUserInteractionEnabled = false
		for view in self.view.subviews {
			if let subView = view as? UIScrollView {
				if subView.tag != -1
				{
				for gesture in subView.gestureRecognizers ?? []
				{
				subView.removeGestureRecognizer(gesture)
				}
				}
			}
		}
	}
}
extension UIView {
	func loadXibView(with xibFrame: CGRect) -> UIView {
		let className = String(describing: type(of: self))
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: className, bundle: bundle)
		guard let xibView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
			return UIView()
		}
		xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		xibView.frame = xibFrame
		return xibView
	}
}
extension Bundle {

	static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
		if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
			return view
		}

		fatalError("Could not load view with type " + String(describing: type))
	}
}
