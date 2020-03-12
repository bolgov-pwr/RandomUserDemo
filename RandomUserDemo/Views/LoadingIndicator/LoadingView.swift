//
//  loadingView.swift
//  MVVMRx
//
//  Created by Mohammad Zakizadeh on 7/26/18.
//  Copyright © 2018 Storm. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
	
	private let messageLabel: UILabel = {
		let lbl = UILabel()
		lbl.textColor = UIColor.white
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	private let animateView: AnimateLoadingView = {
		let v = AnimateLoadingView()
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
		
	private let containerView = UIView()
	
	var loadingViewMessage: String = "" {
        didSet {
            messageLabel.text = loadingViewMessage
        }
    }
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError()
    }
	
    private func commonInit(){
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        containerView.addBlurAreaForLoading(area: containerView.bounds, style: .dark)
		containerView.bringSubviewToFront(messageLabel)
		
		[messageLabel, animateView].forEach { containerView.addSubview($0) }
		installConstraints()
    }
	
	func startAnimation(){
        if animateView.isAnimating {return}
        animateView.startAnimating()
    }
	
	func stopAnimation(){
        animateView.stopAnimating()
    }
	
	private func installConstraints() {
		NSLayoutConstraint.activate([
			animateView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
			animateView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
			animateView.heightAnchor.constraint(equalTo: animateView.widthAnchor),
			animateView.centerXAnchor.constraint(equalTo: centerXAnchor),
			animateView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -5),
			
			messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
			messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
		])
	}
}
