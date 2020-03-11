//
//  UIKitExtensions.swift
//  Randomuser
//
//  Created by Ivan Bolgov on 10/14/19.
//  Copyright © 2019 Ivan Bolgov. All rights reserved.
//

import UIKit

extension UIView {
	
	func addBlurAreaForLoading(area: CGRect, style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        let container = UIView(frame: area)
        blurView.frame = CGRect(x: 0, y: 0, width: area.width, height: area.height)
        container.addSubview(blurView)
        self.insertSubview(container, at: 1)
    }
	
	func fillToSuperView(){
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}

extension UIColor {
	
	class func hex(_ hexStr: NSString, alpha: CGFloat) -> UIColor {
//        let realHexStr = hexStr.replacingOccurrences(of: "#", with: "")
//        let scanner = Scanner(string: realHexStr as String)
        let color: UInt32 = 0
//        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
//        } else {
//            return UIColor.white
//        }
    }
	
	enum DirectionGradient {
		case rightBottomToLeftTop
		case leftBottomToRightTop
		case rightTopToLeftBottom
		case leftATopToRightBottom
		case fromBottomToTop
	}
	
	static func gradientWithDirection(frame: CGRect, colors: [UIColor] = [UIColor.hex("2145FF", alpha: 0.8),
																   UIColor.hex("1F4FFC", alpha: 0.8),
																   UIColor.hex("0E9BE9", alpha: 0.8),
																   UIColor.hex("05C5DF", alpha: 0.8),
																   UIColor.hex("00DADA", alpha: 0.8)],
							   direction: DirectionGradient) -> UIColor {
		
		let backgroundGradientLayer = CAGradientLayer()
		backgroundGradientLayer.frame = frame
		
		switch direction {
		case .rightBottomToLeftTop:
			backgroundGradientLayer.startPoint = CGPoint(x: 1, y: 1)
			backgroundGradientLayer.endPoint = CGPoint(x: 0, y: 0)
		case .leftBottomToRightTop:
			backgroundGradientLayer.startPoint = CGPoint(x: 0, y: 1)
			backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 0)
		case .rightTopToLeftBottom:
			backgroundGradientLayer.startPoint = CGPoint(x: 1, y: 0)
			backgroundGradientLayer.endPoint = CGPoint(x: 0, y: 1)
		case .leftATopToRightBottom:
			backgroundGradientLayer.startPoint = CGPoint(x: 0, y: 0)
			backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 1)
		case .fromBottomToTop:
			backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
			backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
		}
		
		let cgColors = colors.map({$0.cgColor})
		
		backgroundGradientLayer.colors = cgColors
		
		UIGraphicsBeginImageContext(backgroundGradientLayer.bounds.size)
		
		if let context = UIGraphicsGetCurrentContext() {
			backgroundGradientLayer.render(in: context)
		}
		
		let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
		
		
		UIGraphicsEndImageContext()
		
		return UIColor(patternImage: backgroundColorImage ?? UIImage())
	}

}
