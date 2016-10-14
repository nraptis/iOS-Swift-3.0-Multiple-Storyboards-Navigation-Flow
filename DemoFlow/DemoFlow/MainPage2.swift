//
//  MainPage2.swift
//  DemoFlow
//
//  Created by Raptis, Nicholas on 10/13/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class MainPage2: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Main Page 1"
    }
    
    @IBAction func switchStoryboard(_ sender: UIButton) {
        AppDelegate.root.setStoryboard(UIStoryboard(name: "Tutorial", bundle: Bundle.main), animated: true)
    }
    
    @IBAction func showNextPage(_ sender: UIButton) {
        performSegue(withIdentifier: "page_1", sender: nil)
    }
    
    deinit {
        print("Killed Main Page 2")
    }
}
