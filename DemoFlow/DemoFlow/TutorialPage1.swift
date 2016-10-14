//
//  TutorialPage1.swift
//  DemoFlow
//
//  Created by Raptis, Nicholas on 10/13/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class TutorialPage1: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Tutorial Page 1"
    }
    
    @IBAction func switchStoryboard(_ sender: UIButton) {
        AppDelegate.root.setStoryboard(UIStoryboard(name: "Main", bundle: Bundle.main), animated: true)
    }
    
    @IBAction func showNextPage(_ sender: UIButton) {
        performSegue(withIdentifier: "page_2", sender: nil)
    }
    
    deinit {
        print("Killed Tutorial Page 1")
    }

}
