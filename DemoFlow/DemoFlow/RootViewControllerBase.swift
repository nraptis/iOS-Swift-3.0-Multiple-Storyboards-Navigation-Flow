//
//  RootViewControllerBase.swift
//  DemoFlow
//
//  Created by Raptis, Nicholas on 10/13/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

//All of the layout constraints inset by 5 to illustrate the framing..

class RootViewControllerBase: UIViewController {
    
    var rootContainerView: UIView!
    
    private var _currentStoryboard: UIStoryboard?
    
    private var _currentViewController: UIViewController?
    private var _previousViewController: UIViewController?
    
    var updateTimer:Timer?
    
    var colorCycleIndex:Int = 0
    var colorCycleTimer:Int = 0
    var color:[CGFloat] = [1.0, 1.0, 1.0]
    var colorStart:CGFloat = 1.0
    var colorTarget:CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        rootContainerView = UIView(frame: CGRect.zero)
        rootContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rootContainerView)
        let containerConstraintLeft = NSLayoutConstraint(item: rootContainerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 5)
        let containerConstraintRight = NSLayoutConstraint(item: rootContainerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -5)
        let containerConstraintTop = NSLayoutConstraint(item: rootContainerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 5)
        let containerConstraintBottom = NSLayoutConstraint(item: rootContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -5)
        view.addConstraints([containerConstraintLeft, containerConstraintRight, containerConstraintTop, containerConstraintBottom])
        
        updateTimer?.invalidate()
        updateTimer = Timer.scheduledTimer(timeInterval: 1.0/60.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        if updateTimer != nil {
            RunLoop.main.add(updateTimer!, forMode: RunLoopMode.commonModes)
        }
        
        view.setNeedsLayout()
        view.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        
        //This is just to make it look cool.
        colorCycleTimer += 1
        
        let percent = CGFloat(colorCycleTimer) / CGFloat(60.0)
        
        color[colorCycleIndex] = colorStart + (colorTarget - colorStart) * percent
        if color[colorCycleIndex] > 1.0 { color[colorCycleIndex] = 1.0 }
        if color[colorCycleIndex] < 0.0 { color[colorCycleIndex] = 0.0 }
        
        rootContainerView.backgroundColor = UIColor(red: color[0], green: color[1], blue: color[2], alpha: 1.0)
        
        _currentViewController?.view.backgroundColor = UIColor(red: 1.0 - color[0], green: 1.0 - color[1], blue: 1.0 - color[2], alpha: 1.0)
        if colorCycleTimer >= 60 {
            colorCycleTimer = 0
            colorCycleIndex = abs(Int(arc4random())) % 3
            colorStart = color[colorCycleIndex]
            let dest = abs(Int(arc4random())) % 3
            if dest == 0 {
                colorTarget = 0.0
            } else if dest == 1 {
                colorTarget = 0.5
            } else {
                colorTarget = 1.0
            }
        }
    }
    
    
    
    func setStoryboard(_ storyboard: UIStoryboard?, animated: Bool) {
        _currentStoryboard = storyboard
        if let sb = _currentStoryboard {
            setViewController(sb.instantiateInitialViewController(), animated: animated)
        }
    }
    
    func setViewController(_ viewController: UIViewController?, animated: Bool) {
        
        guard _currentViewController != viewController else { return }
        
        if let vc = viewController {
            
            _previousViewController = _currentViewController
            
            var anim = animated
            
            if _previousViewController == nil { anim = false }
            
            if anim == false && _previousViewController != nil {
                _previousViewController!.view.removeFromSuperview()
            }
            
            _currentViewController = viewController
            
            rootContainerView.addSubview(vc.view)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            
            let constraintLeft = NSLayoutConstraint(item: vc.view, attribute: .leading, relatedBy: .equal, toItem: rootContainerView, attribute: .leading, multiplier: 1.0, constant: 5)
            let constraintRight = NSLayoutConstraint(item: vc.view, attribute: .trailing, relatedBy: .equal, toItem: rootContainerView, attribute: .trailing, multiplier: 1.0, constant: -5)
            let constraintTop = NSLayoutConstraint(item: vc.view, attribute: .top, relatedBy: .equal, toItem: rootContainerView, attribute: .top, multiplier: 1.0, constant: 5)
            let constraintBottom = NSLayoutConstraint(item: vc.view, attribute: .bottom, relatedBy: .equal, toItem: rootContainerView, attribute: .bottom, multiplier: 1.0, constant: -5)
            
            
            rootContainerView.addConstraints([constraintLeft, constraintRight, constraintTop, constraintBottom])
            rootContainerView.setNeedsLayout()
            rootContainerView.layoutIfNeeded()
            
            if anim {
                
                _previousViewController?.view.isUserInteractionEnabled = false
                
                vc.view.layer.transform = CATransform3DMakeTranslation(0.0, rootContainerView.bounds.height, 0.0)
                
                UIView.animate(withDuration: 0.4, animations: { [weak weakSelf = self] in
                    
                    if let checkSelf = weakSelf {
                        checkSelf._previousViewController?.view.layer.transform = CATransform3DMakeTranslation(0.0, -checkSelf.rootContainerView.bounds.height, 0.0)
                        checkSelf._currentViewController?.view.layer.transform = CATransform3DIdentity
                    }
                    
                    }, completion: { [weak weakSelf = self] (finished:Bool) in
                        
                        weakSelf?._previousViewController?.view.removeFromSuperview()
                        weakSelf?._previousViewController = nil
                        
                    })
                
            } else {
                
            }
        }
    }
}






