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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        rootContainerView = UIView(frame: CGRect.zero)
        rootContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rootContainerView)
        let containerConstraintLeft = NSLayoutConstraint(item: rootContainerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let containerConstraintRight = NSLayoutConstraint(item: rootContainerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let containerConstraintTop = NSLayoutConstraint(item: rootContainerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let containerConstraintBottom = NSLayoutConstraint(item: rootContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        view.addConstraints([containerConstraintLeft, containerConstraintRight, containerConstraintTop, containerConstraintBottom])

        view.setNeedsLayout()
        view.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            
            
            _currentViewController = viewController
            
            rootContainerView.addSubview(vc.view)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            
            let constraintLeft = NSLayoutConstraint(item: vc.view, attribute: .leading, relatedBy: .equal, toItem: rootContainerView, attribute: .leading, multiplier: 1.0, constant: 0.0)
            let constraintRight = NSLayoutConstraint(item: vc.view, attribute: .trailing, relatedBy: .equal, toItem: rootContainerView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            let constraintTop = NSLayoutConstraint(item: vc.view, attribute: .top, relatedBy: .equal, toItem: rootContainerView, attribute: .top, multiplier: 1.0, constant: 0.0)
            let constraintBottom = NSLayoutConstraint(item: vc.view, attribute: .bottom, relatedBy: .equal, toItem: rootContainerView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
            
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
                        
                        //Remove the view after the animation.
                        weakSelf?._previousViewController?.view.removeFromSuperview()
                        weakSelf?._previousViewController = nil
                        
                    })
                
            } else {
                if _previousViewController != nil {
                    //Remove the view immediately.
                    _previousViewController!.view.removeFromSuperview()
                    _previousViewController = nil
                }
            }
        }
    }
}






