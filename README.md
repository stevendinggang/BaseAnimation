# BaseAnimation
创造101 实力女团, 大家要一边学习动画,一遍了解一下,国产女团的魅力

其实iOS基本动画组合一下,也是可以做出很不错的效果的大家有时间可以试试

// 基本动画

 UIView.animate(withDuration: 0.8, delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 10.0,
                       animations: {
            conBottom.constant = -imageView.frame.size.height / 2
            conWidth.constant = 0.0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
 //旋转消失
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
 









