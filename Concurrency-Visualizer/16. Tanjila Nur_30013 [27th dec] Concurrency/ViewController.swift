//
//  ViewController.swift
//  16. Tanjila Nur_30013 [27th dec] Concurrency
//
//  Created by BJIT on 27/12/22.
//

import UIKit

enum ConcurrencyType{
    case customSerialSync, customSerialAsync, globalConcurrentSync, globalConcurrentAsync, customConcurrentAsync
}

class ViewController: UIViewController {
    
    @IBOutlet var executionTimes: [UITextField]!
    
    @IBOutlet var concurrencyButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func serialSyncButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotTovisualizer" , sender: sender)
    }
    
    @IBAction func serialAsyncButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotTovisualizer" , sender: sender)
    }
    
    @IBAction func concurrentSyncButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotTovisualizer" , sender: sender)
    }
    
    @IBAction func concurrentAsyncButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotTovisualizer" , sender: sender)
    }
    
    @IBAction func customConcurrentAsyncButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "gotTovisualizer" , sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotTovisualizer" {
            if let vc = segue.destination as? VisualizerViewController {
              //  vc.loadViewIfNeeded()
                
                if let sender = sender as? UIButton {
                    vc.title = sender.titleLabel?.text ?? ""

                    vc.sleeoOfTasks[0] = UInt32(executionTimes[0].text!)!
                    vc.sleeoOfTasks[1] = UInt32(executionTimes[1].text!)!
                    vc.sleeoOfTasks[2] = UInt32(executionTimes[2].text!)!
                    
                    if sender == concurrencyButtons[0] {
                        vc.concurrencyType = .customSerialSync
                    } else if sender == concurrencyButtons[1] {
                        vc.concurrencyType = .customSerialAsync
                    } else if sender == concurrencyButtons[2] {
                        vc.concurrencyType = .globalConcurrentSync
                    } else if sender == concurrencyButtons[3] {
                        vc.concurrencyType = .globalConcurrentAsync
                    } else {
                        vc.concurrencyType = .customConcurrentAsync
                    }
                }
                
            }
        }
    }
}


