//
//  VisualizerViewController.swift
//  16. Tanjila Nur_30013 [27th dec] Concurrency
//
//  Created by BJIT on 27/12/22.
//

import UIKit

class VisualizerViewController: UIViewController {
    
    var concurrencyType: ConcurrencyType?
    
    var sleeoOfTasks: [UInt32] = [1,1,1]
    
    @IBOutlet weak var dispatchBtn: UIButton!
    
    @IBOutlet var task1Views: [UIView]!
    
    @IBOutlet var task2Views: [UIView]!
    
    @IBOutlet var task3Views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        startVisualizing()
        dispatchBtn.alpha = 0.25
        dispatchBtn.isEnabled = false
        
    }
    //MARK: Reusable Functions
    func startVisualizing() {
        let mainSerialQueue = DispatchQueue(label: "com.async.serial.main")
        
        mainSerialQueue.async { [weak self] in
            
            guard let self = self else{return}
            
            if self.concurrencyType == .customSerialSync {
                self.visualizeSerialSync()
            } else if self.concurrencyType == .customSerialAsync {
                self.visualizeSerialAsync()
            } else if self.concurrencyType == .globalConcurrentSync {
                self.visualizeGlobalConcurrentSync()
            } else if self.concurrencyType == .globalConcurrentAsync {
                self.visualizeGlobalConcurrentAsync()
            } else {
                self.visualizeCustomConcurrentAsync()
            }
        }
    }
    
    func doTask(_ sleepOfTask:UInt32,_ taskViews:[UIView]){
        for i in 0..<5 {
            sleep(sleepOfTask)
            DispatchQueue.main.async{
                taskViews[i].backgroundColor = .orange
            }
            if i == 4 {
                for i in 0..<5 {
                    DispatchQueue.main.async{
                        taskViews[i].backgroundColor = .green
                    }
                }
            }
            //            for j in 0...10000000{
            //               let s = j * 1000
            //               print(s)
            //            }
        }
    }
    
    //MARK: Concurrency Visualizer Functions
    
    func visualizeSerialSync(){
        
        let serialQueue = DispatchQueue(label: "com.sync.serial")
        serialQueue.sync { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[0], self.task1Views)
        }
        serialQueue.sync { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[1], self.task2Views)
        }
        serialQueue.sync { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[2], self.task3Views)
        }
    }
    
    func visualizeSerialAsync(){
        
        let serialQueue = DispatchQueue(label: "com.async.serial")
        serialQueue.async { [weak self] in
            
            guard let self = self else{return}
            self.doTask(self.sleeoOfTasks[0], self.task1Views)
        }
        serialQueue.async { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[1], self.task2Views)
        }
        serialQueue.async { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[2], self.task3Views)
        }
    }
    
    func visualizeGlobalConcurrentSync(){
        
        let concurrentQueue = DispatchQueue.global()
        
        concurrentQueue.sync { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[0], self.task1Views)
        }
        concurrentQueue.sync { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[1], self.task2Views)
        }
        concurrentQueue.sync { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[2], self.task3Views)
        }
    }
    
    func visualizeGlobalConcurrentAsync(){
        
        let concurrentQueue = DispatchQueue.global()
        
        concurrentQueue.async { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[0], self.task1Views)
        }
        concurrentQueue.async { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[1], self.task2Views)
        }
        concurrentQueue.async { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[2], self.task3Views)
        }
        
    }
    
    
    func visualizeCustomConcurrentAsync(){
        
        let customConcurrentQueue = DispatchQueue(label: "com.async.concurrent", attributes: .concurrent)
        
        customConcurrentQueue.async { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[0], self.task1Views)
        }
        customConcurrentQueue.sync { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[1], self.task2Views)
        }
        customConcurrentQueue.async { [weak self] in
            guard let self = self else{return}
            
            self.doTask(self.sleeoOfTasks[2], self.task3Views)
        }
    }
}
