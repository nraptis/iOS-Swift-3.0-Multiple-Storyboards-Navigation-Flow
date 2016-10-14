//
//  RootViewController.swift
//  DemoFlow
//
//  Created by Raptis, Nicholas on 10/13/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class RootViewController: RootViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStoryboard(UIStoryboard(name: "Tutorial", bundle: Bundle.main), animated: false)
        
        /*
        let nc = storyboard.instantiateViewController(withIdentifier: "main_nav") as! UINavigationController
        nc.view.frame = view.bounds
        view.addSubview(nc.view)
        nc.view.setNeedsLayout()
        */
        
        
        
        //let home = storyboard.instantiateViewController(withIdentifier: "tutorial_root") as! TutorialRoot
        
        //view.addSubview(home.view)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
