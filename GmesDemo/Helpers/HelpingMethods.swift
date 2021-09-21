//
//  HelpingMethods.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/19/21.
//

import UIKit
import SystemConfiguration
import SystemConfiguration
enum ToastType {
	case success
	case error
	case failure
	case alert
}

class HelpingMethods {



	class func dropBtnTextShadow(btn:UIButton) {
		btn.layer.shadowColor = UIColor.lightGray.cgColor
		btn.layer.shadowOffset = CGSize(width: 1, height: 1)
		btn.layer.shadowRadius = 1
		btn.layer.shadowOpacity = 1.0
	}



	/// This method will return attributted text for Label, Button, Text Field and Text View
	class func getTextAttributes(color: UIColor, font: UIFont, alignment: NSTextAlignment, lineHeight: CGFloat,
								 letterSpace: CGFloat) -> [NSAttributedString.Key: Any] {

		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = alignment
		paragraphStyle.minimumLineHeight = 16

		let attributes = [ .font: font, .paragraphStyle: paragraphStyle, .foregroundColor: color,
						   .kern: letterSpace ] as [NSAttributedString.Key: Any]
		return attributes
	}

	// MARK: - herlpers
	func dropShadow(view: UIView) {
		//view.layer.cornerRadius = 15
		view.layer.shadowOpacity = 0.1
		view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
		view.layer.shadowRadius = 10.0
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.masksToBounds = false
	}

	func dropShadowHeader(view: UIView) {
		view.layer.shadowOpacity = 0.2
		view.layer.shadowOffset = CGSize(width: 1.0, height: 5.0)
		view.layer.shadowRadius = 10.0
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.masksToBounds = true
	}

	func heightForLabel(text: String, font: UIFont, width: CGFloat) -> CGFloat {
		let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height:  CGFloat.greatestFiniteMagnitude))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.font = font
		label.text = text
		label.sizeToFit()
		return label.frame.height
	}

	class func isConnectedToNetwork() -> Bool {
		var zeroAddress = sockaddr_in()
		zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
		zeroAddress.sin_family = sa_family_t(AF_INET)
		let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
			$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
				SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
			}
		}
		var flags = SCNetworkReachabilityFlags()
		if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
			return false
		}
		let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
		let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
		return (isReachable && !needsConnection)
	}



	// when not in debug mode stop printing to consol
	static var amInDebugmodeSoPrintingIsAllwed = true

	// MARK: isphaSuperPrintFunction
	class  func printStringBy_ispha(string: String) {
		if amInDebugmodeSoPrintingIsAllwed == true {
			print(string)
		}
	}

	class  func printAnyobjectBy_ispha(anyObject: AnyObject) {
		if amInDebugmodeSoPrintingIsAllwed == true {
			print(anyObject)
		}
	}

	class  func printStringWithAnyobjectBy_ispha(string: String , anyObject: AnyObject) {
		if amInDebugmodeSoPrintingIsAllwed == true {
			print("\(string) , \(anyObject)")
		}
	}

	class  func printCustomObjectBy_ispha( anyObject: AnyObject) {
		if amInDebugmodeSoPrintingIsAllwed == true {
			let mirrored_object = Mirror(reflecting: anyObject)
			for (index, attr) in mirrored_object.children.enumerated() {
				if let property_name = attr.label as String? {
					print("🔥 Attr \(index): \(property_name) = \(attr.value)")
				}
			}
		}
	}

	class func showAlertBy__ispha(title: String, messgae: String, delegate: UIViewController) {
		let alertController = UIAlertController(title: title, message: messgae, preferredStyle: .alert)
		let OKAction = UIAlertAction(title: NSLocalizedString("حسنا", comment: ""), style: .default) { (action) in }
		alertController.addAction(OKAction)
		delegate.present(alertController, animated: true, completion: nil)
	}

	class  func colorWithHexString (_ hex: String) -> UIColor {
		var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
		if (cString.hasPrefix("#")) {
			cString = (cString as NSString).substring(from: 1)
		}
		if (cString.count != 6) {
			return UIColor.gray
		}
		let rString = (cString as NSString).substring(to: 2)
		let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
		let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)

		var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
		Scanner(string: rString).scanHexInt32(&r)
		Scanner(string: gString).scanHexInt32(&g)
		Scanner(string: bString).scanHexInt32(&b)
		return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
	}

	class  func noDataFound(tableView: UITableView, msg: String) {
		let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
		noDataLabel.text = msg
		noDataLabel.textColor = UIColor.black
		noDataLabel.textAlignment = .center
		tableView.backgroundView  = noDataLabel
		tableView.separatorStyle = .none
		tableView.reloadData()
	}

	class func showAlert(title: String, messgae: String, delegate: UIViewController) {
		let alertController = UIAlertController(title: title, message: messgae, preferredStyle: .alert)
		let OKAction = UIAlertAction(title: HelpingMethods.localizeKeyword(word: "ok"), style: .default) { (action) in }
		alertController.addAction(OKAction)
		delegate.present(alertController, animated: true, completion: nil)
	}

	class func alertCompletion(title: String , message :String ,delegate: UIViewController, alertActionTitle: String, action: ((UIAlertAction) -> Void)?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: HelpingMethods.localizeKeyword(word: "ok"), style: .default, handler:action)
		alert.addAction(okAction)
		delegate.present(alert, animated: true, completion: nil)
	}

	class func alertCompletionwithCancel(title: String, message: String, delegate: UIViewController, alertActionTitle: [String], action: ((UIAlertAction) -> Void)?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: alertActionTitle[0], style: .cancel, handler:action)
		let cancelAction = UIAlertAction(title: alertActionTitle[1], style: .destructive, handler:nil)

		alert.addAction(okAction)
		alert.addAction(cancelAction)
		delegate.present(alert, animated: true, completion: nil)
	}

	class func printString(string: String) {
		if amInDebugmodeSoPrintingIsAllwed == true {
			print(string)
		}
	}

	class func printStringWithAnyobject(string: String, anyObject: AnyObject) {
		if amInDebugmodeSoPrintingIsAllwed == true {
			print("\(string) , \(anyObject)")
		}
	}

	class func makeViewBorderRounder(view: UIView, cornerRadius: CGFloat, borderColor: UIColor = .white, borderWidth: CGFloat = 0) {
		view.layer.cornerRadius = cornerRadius
		view.layer.borderWidth = borderWidth
		view.layer.borderColor = borderColor.cgColor
		view.layer.masksToBounds = true
	}

	class func makeViewCorner(view: UIView, roundedCorners: UIRectCorner, cornerRadius: CGFloat = 8.0) {
		let rectShape = CAShapeLayer()
		rectShape.bounds = view.frame
		rectShape.position = view.center
		rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: roundedCorners , cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
		view.layer.mask = rectShape
	}

	class func calculateHeight(inString: String, size: Float, width: CGFloat) -> CGFloat {
		let messageString = inString
		let attributes  = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))]
		let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
		let rect : CGRect = attributedString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
		let requredSize:CGRect = rect
		return ceil(requredSize.height)
	}

	class func secondsToHoursMinutesSeconds (seconds: Int) -> (d: Int, h: Int, m: Int, s: Int) {
		return (d:Int(seconds / 86400),h:Int((seconds % 86400) / 3600),m: Int((seconds % 3600) / 60),s: Int((seconds % 3600) % 60))
	}

	class func MakeCall(number: String, delegate: UIViewController) {
		if let url = URL(string: "tel://\(number)") {
			UIApplication.shared.open(url)
		} else {
			showAlert(title: "", messgae: HelpingMethods.localizeKeyword(word: "Can't Makle call for this number"), delegate: delegate)
		}
	}

	class func contentNotFound(tableView: UITableView, enable: Bool, msg: String) {
		let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
		noDataLabel.numberOfLines = 0
		noDataLabel.text = enable == true ? msg : ""
		noDataLabel.textColor = UIColor.black
		noDataLabel.textAlignment = .center
		tableView.backgroundView  = noDataLabel
		tableView.reloadData()
	}

	class func getTodayName() -> String {
		let date = Date()
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE"
		let dayInWeek = formatter.string(from: date)
		return dayInWeek
	}


	class func isUserLogged() -> Bool {
		if UserDefaults.standard.value(forKey: "Authorization") != nil {
			return true
		} else {
			return false
		}
	}

	class func setCurrentLan(lang: String) {
		UserDefaults.standard.set(lang, forKey: "lang")
	}

	class func getCurrentLang() -> String {
		if UserDefaults.standard.value(forKey: "lang") != nil {
			return UserDefaults.standard.value(forKey: "lang") as! String
		} else {
			UserDefaults.standard.set("ar", forKey: "lang")
			return "ar"
		}
	}

	class func emptyTableView(tableView: UITableView, dataCount: Int, dataCome: Bool, emptyTableViewMessage: String) -> Int {
		if dataCome {
			if dataCount > 0 {
				tableView.backgroundView = nil
			} else {
				let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: tableView.tableHeaderView != nil ? tableView.tableHeaderView?.frame.size.height ?? 0.0 + 100 :  (tableView.frame.size.height / 2 ) - 60 , width: tableView.bounds.size.width, height: 60))
				noDataLabel.text = emptyTableViewMessage
				noDataLabel.textColor = UIColor.darkGray
				noDataLabel.textAlignment = .center
				let view = UIView(frame: tableView.frame)
				view.addSubview(noDataLabel)
				tableView.backgroundView  = view
			}
			return dataCount
		}
		return 0
	}

	class func emptyCollecitonView(tableView: UICollectionView, dataCount: Int, dataCome: Bool, emptyTableViewMessage: String) -> Int {
		if dataCome{
			if dataCount > 0 {
				tableView.backgroundView = nil
			} else {
				let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
				noDataLabel.text          = emptyTableViewMessage
				noDataLabel.textColor     = UIColor.darkGray
				noDataLabel.textAlignment = .center
				tableView.backgroundView  = noDataLabel
			}
			return dataCount
		}
		return 0
	}

	class func UTCConvertDateformate(date: String, fromFormat: String, toFormat: String) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = fromFormat
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		let dt = dateFormatter.date(from: date)
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.dateFormat = toFormat
		return dateFormatter.string(from: dt!)
	}

	class func alertCompletionBy__abonabih(title: String, message :String, delegate: UIViewController, alertActionTitle: String, action: ((UIAlertAction) -> Void)?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: alertActionTitle, style: .default, handler:action)
		alert.addAction(okAction)
		delegate.present(alert, animated: true, completion: nil)
	}

	class func cellStyle(containerView: UIView) {
		containerView.layer.shadowColor = UIColor.lightGray.cgColor
		containerView.layer.shadowOpacity = 4
		containerView.layer.shadowOffset = CGSize.zero
		containerView.layer.shadowRadius = 5
	}

	class func makeViewBorder(view: UIView, borderWidth: CGFloat = 0.0, borderColor: UIColor = .clear) {
		view.layer.borderColor = borderColor.cgColor
		view.layer.borderWidth = borderWidth
	}

	class func makeViewShadow(view: UIView, shadowOpacity: Float, shadowRadius: CGFloat, shadowColor: UIColor) {
		view.layer.shadowColor = shadowColor.cgColor
		view.layer.shadowOpacity = shadowOpacity
		view.layer.shadowOffset = CGSize.zero
		view.layer.shadowRadius = shadowRadius
	}

	class func isValidEmail(testStr: String) -> Bool {
		let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		let result = emailTest.evaluate(with: testStr)
		return result
	}

	class func showActionsheet(viewController: UIViewController, view: UIView, title: String, message: String, actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: Int) -> Void) {
		let alertViewController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		for (index, (title, style)) in actions.enumerated() {
			let alertAction = UIAlertAction(title: title, style: style) { (_) in
				completion(index)
			}
			alertViewController.addAction(alertAction)
		}
		alertViewController.popoverPresentationController?.sourceView = view
		viewController.present(alertViewController, animated: true, completion: nil)
	}

	class func localizeKeyword(word: String) -> String {
		return NSLocalizedString(word, comment: "")
	}

	class func showToast(controller: UIViewController, message: String, seconds: Double, success: Bool) {
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
		if success {
			alert.view.backgroundColor = UIColor.green
		} else {
			alert.view.backgroundColor = UIColor.red
		}
		alert.view.alpha = 0.5
		alert.view.layer.cornerRadius = 15
		controller.present(alert, animated: true)
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
			alert.dismiss(animated: true)
		}
	}

	class func applyShadwo(v: UIView) {
		v.layer.shadowColor = UIColor.black.cgColor
		v.layer.shadowOpacity = 0.3
		v.layer.shadowOffset = .zero
		v.layer.shadowRadius = 10
		v.layer.cornerRadius = 12
	}

	class func generateBarcode(from string: String) -> UIImage? {
		let data = string.data(using: String.Encoding.ascii)
		if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
			filter.setDefaults()
			//Margin
			filter.setValue(7.00, forKey: "inputQuietSpace")
			filter.setValue(data, forKey: "inputMessage")
			//Scaling
			let transform = CGAffineTransform(scaleX: 3, y: 3)

			if let output = filter.outputImage?.transformed(by: transform) {
				let context:CIContext = CIContext.init(options: nil)
				let cgImage:CGImage = context.createCGImage(output, from: output.extent)!
				let rawImage:UIImage = UIImage.init(cgImage: cgImage)

				//Refinement code to allow conversion to NSData or share UIImage. Code here:
				//http://stackoverflow.com/questions/2240395/uiimage-created-from-cgimageref-fails-with-uiimagepngrepresentation
				let cgimage: CGImage = (rawImage.cgImage)!
				let cropZone = CGRect(x: 0, y: 0, width: Int(rawImage.size.width), height: Int(rawImage.size.height))
				let cWidth: size_t  = size_t(cropZone.size.width)
				let cHeight: size_t  = size_t(cropZone.size.height)
				let bitsPerComponent: size_t = cgimage.bitsPerComponent
				//THE OPERATIONS ORDER COULD BE FLIPPED, ALTHOUGH, IT DOESN'T AFFECT THE RESULT
				let bytesPerRow = (cgimage.bytesPerRow) / (cgimage.width  * cWidth)

				let context2: CGContext = CGContext(data: nil, width: cWidth, height: cHeight, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: cgimage.bitmapInfo.rawValue)!
				context2.draw(cgimage, in: cropZone)
				let result: CGImage  = context2.makeImage()!
				let finalImage = UIImage(cgImage: result)
				return finalImage
			}
		}
		return nil
	}

	class func generateQRCode(from string: String, completionHandler: @escaping (_ homeContent: AnyObject?) -> Void) {
		let data = string.data(using: String.Encoding.ascii)
		if let filter = CIFilter(name: "CIQRCodeGenerator") {
			filter.setValue(data, forKey: "inputMessage")
			let transform = CGAffineTransform(scaleX: 10, y: 10)
			if let output = filter.outputImage?.transformed(by: transform) {
				completionHandler( UIImage(ciImage: output))
			} else {
				completionHandler(nil)
			}
		} else {
			completionHandler(nil)
		}
	}



	class func showHideTabBar(flag:Bool)
	{
		SingletoneClass.sharedInstance.tabbarView?.isHidden = !flag
		SingletoneClass.sharedInstance.tabbarConstraintBotm?.constant = flag == true ? 0 : -((SingletoneClass.sharedInstance.tabBarInnerView?.frame.size.height)! - 46)
	}
	class func convertImageToBase64String (img: UIImage) -> String {
		return img.jpegData(compressionQuality: 0.1)?.base64EncodedString(options: .lineLength64Characters) ?? ""
	}
	class func convertBase64StringToImage(base64String : String) -> UIImage?
	{
		let decodedData = NSData(base64Encoded: base64String, options: [])
		if let data = decodedData {
			let decodedimage = UIImage(data: data as Data)
			return decodedimage
		} else {
			print("error with decodedData")
			return nil
		}
	}
	func formatTime(time : String) -> String{
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE, d, MMMM, yyyy HH:mm a"
		if let date = formatter.date(from: time) {
			// set locale to "ar_DZ" and format as per your specifications
			//formatter.locale = NSLocale(localeIdentifier: "ar") as Locale!
			formatter.dateFormat = "EEEE, d, MMMM"
			formatter.locale = NSLocale(localeIdentifier: "ar_DZ") as Locale?
			let outputDate = formatter.string(from: date)

			//print(outputDate) // الأربعاء, 9 مارس, 2016 10:33 ص
			return outputDate
		}
		else{
			return ""
		}

	}
}

enum StorageType {
	case userDefaults
	case fileSystem
}
