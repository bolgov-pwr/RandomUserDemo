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

extension UIImage {

    func decodedImage() -> UIImage {
        guard let cgImage = cgImage else { return self }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let decodedImage = context?.makeImage() else { return self }
        return UIImage(cgImage: decodedImage)
    }
	
	
}


enum CornerRadiusOption {
	case cicle
	case custom(value: CGFloat)
}

extension UIImageView {
	
	func resizedImage(image: UIImage, cornerRadius: CornerRadiusOption) {
		
		let size = image.size
		let targetRect = bounds
		let targetSize = bounds.size
		
		DispatchQueue.global(qos: .userInitiated).async {
			let widthRatio  = targetSize.width  / size.width
			let heightRatio = targetSize.height / size.height

			var newSize: CGSize
			if(widthRatio > heightRatio) {
				newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
			} else {
				newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
			}

			let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

			UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
			
			switch cornerRadius {
			case .cicle:
				UIBezierPath(roundedRect: targetRect, cornerRadius: targetSize.width / 2).addClip()
			case .custom(let value):
				UIBezierPath(roundedRect: targetRect, cornerRadius: value).addClip()
			}
			
			image.draw(in: rect)
			let newImage = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			
			DispatchQueue.main.async { [weak self] in
				self?.image = newImage
			}
		}
	}
}
