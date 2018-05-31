//
//  ViewController.swift
//  101List
//
//  Created by Steven on 2018/5/30.
//  Copyright © 2018年 Steven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var buttonItem: UILabel!
    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var menuViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addButtonTrailing: NSLayoutConstraint!
    
    var slider: HoriziontalltemList!

    var isMenuOpen = false
    
    let itemTitles = ["Mena","陈盈燕", "段奥娟", "江璟儿", "菊麟", "刘尼夷", "鹿小草", "孟美岐", "潘珺雅", "强东玥", "邵夏", "王晴", "王亦然", "吴宣仪", "杨蕊菡", "杨芸晴", "于美红", "张溪", "赵尧珂", "郑丞丞", "周雪"]
    
    var items: [Int] = [5, 6, 7]

    
    @IBAction func actionToggleMenu(_ sender: AnyObject) {
       
        isMenuOpen = !isMenuOpen
        buttonItem.text = isMenuOpen ? "创造 101" : "帮菊姐上头条"
        view.layoutIfNeeded()
        
        //修改title 位置
        buttonItem.superview?.constraints.forEach({ constraint in
            if constraint.firstItem === buttonItem &&
                constraint.firstAttribute == .centerX {
                constraint.constant = isMenuOpen ? -100 : 0.0
            }
            
            if constraint.identifier == "TitleCenterY" {
               
                constraint.isActive = false
                let newConstraint = NSLayoutConstraint (
                    item: buttonItem, attribute: .centerY, relatedBy: .equal, toItem: buttonItem.superview, attribute: .centerY, multiplier: isMenuOpen ? 0.67 : 1.0, constant: 5.0
                )
                newConstraint.identifier = "TitleCenterY"
                newConstraint.isActive = true
            }
        })
        
        menuViewHeight.constant = isMenuOpen ? 200.0 : 60.0
        addButtonTrailing.constant = isMenuOpen ? 16.0 : 8.0


        UIView.animate(withDuration: 1.0, delay: 0.0,usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 10,  options:[],animations: {
            let angle: CGFloat = self.isMenuOpen ? .pi / 4: 0.0  //旋转 四分之一  pi
            self.addItem.transform = CGAffineTransform.init(rotationAngle: angle)
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
    func showItem(_ index: Int) {
        print("tapped item \(index)")
        
        let imageView = makeImageView(index: index)
        view.addSubview(imageView)
        let conX = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let conBottom = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageView.frame.height)
        let conWidth = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.43, constant: -50.0)
        let conHeight = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        
        NSLayoutConstraint.activate([conX,conBottom,conWidth,conHeight])
        view.layoutIfNeeded()
        
        //Animate in
        UIView.animate(withDuration: 0.8, delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 10.0,
                       animations: {
//           conBottom.constant = -100
            conBottom.constant = -imageView.frame.size.height / 2
            conWidth.constant = 0.0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        //Animate out
        delay(seconds: 1.0, completion: {
         
            UIView.transition(with: imageView, duration: 1.0, options: [
                .curveEaseIn,
                .transitionCrossDissolve
                ], animations: {
                 imageView.isHidden = true
            }, completion: {_ in
                imageView.removeFromSuperview()
            })
        })

//        UIView.animate(withDuration: 0.67, delay: 2.0,
//                       usingSpringWithDamping: 0.6,
//                       initialSpringVelocity: 10.0,
//                       options: [
//                        .curveEaseIn,
//                        .transitionFlipFromBottom
//            ],
//            animations: {
////            conBottom.constant = imageView.frame.size.height
////            conWidth.constant = -50.0
//            imageView.isHidden = true
//
//            self.view.layoutIfNeeded()
//        },completion: { _ in
//            imageView.removeFromSuperview()
//        })
        

        
        
    }
//        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .autoreverse, animations: {
//
//        }, completion: nil)
    
    func transitionCloseMenu() {
        //close the menu with a cool transition
        delay(seconds: 0.35, completion: {
            self.actionToggleMenu(self)
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func makeImageView(index: Int) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "\(index).png"))
        imageView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.bounds = CGRect(x: 0, y: 0, width: 250, height: 250)

        return imageView
    }
    
    
    func makeSlider() {
        slider = HoriziontalltemList.init(inView: view)
        slider.didSelectItem = {index in
            print("add \(index)")
            self.items.append(index)
            self.tableView?.reloadData()
            self.transitionCloseMenu()
        }
        self.buttonItem.superview?.addSubview(slider)
    }
    
    // MARK: View Controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSlider() //创建image
        self.tableView?.rowHeight = 84.0
        self.tableView.tableFooterView = UIView.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .none
//        cell.textLabel?.text = itemTitles[indexPath.row]
        cell.textLabel?.text = itemTitles[items[indexPath.row]]
        cell.imageView?.image = UIImage(named: "\(items[indexPath.row])")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showItem(items[indexPath.row])
    }
    
    
}














































