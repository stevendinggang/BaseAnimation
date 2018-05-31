//
//  HoriziontalltemList.swift
//  101List
//
//  Created by Steven on 2018/5/30.
//  Copyright © 2018年 Steven. All rights reserved.
//

import UIKit

class HoriziontalltemList: UIScrollView {
    
    var didSelectItem:((_ index:Int)->())?
    
    let buttonWidth: CGFloat = 60.0
    let padding: CGFloat = 21.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(inView: UIView) {
        
        let rect = CGRect(x: 0, y: 125, width: inView.frame.width, height: 80.0)

        self.init(frame: rect)
        alpha = 1.0
        
        for i in 0..<21 {
            let image = UIImage(named: "\(i)")
            let imageView = UIImageView(image: image)
//            imageView.center = CGPoint(x: CGFloat(i) * buttonWidth + buttonWidth/2, y: buttonWidth/2)
            imageView.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
            imageView.center = CGPoint(x: CGFloat(i) * buttonWidth + buttonWidth/2, y: buttonWidth/2)

            
            imageView.tag = i
            imageView.isUserInteractionEnabled = true
            addSubview(imageView)
            
//            let tap = UITapGestureRecognizer.init(target: self, action: #selector(HoriziontalltemList.didTapImage(_:)))
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(HoriziontalltemList.didTapImage(_:)))

            imageView.addGestureRecognizer(tap)
            
            print(imageView.frame)
        }
        
        contentSize = CGSize(width: padding * buttonWidth, height:  buttonWidth + 2*10)

    }
    
    //MARK -
    @objc func didTapImage(_ tap: UITapGestureRecognizer) {
        didSelectItem?(tap.view!.tag)
    }

}
