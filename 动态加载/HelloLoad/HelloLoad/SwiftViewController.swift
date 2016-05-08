//
//  SwiftViewController.swift
//  HelloLoad
//
//  Created by Tangguo on 16/5/6.
//  Copyright © 2016年 Tangguo. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //https://dn-heyue.qbox.me/HelloDy.framework.zip
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let button = UIButton(type: .Custom)
        button.setTitle("调用frameWork", forState: .Normal)
        button.frame = CGRect(x: 50, y: 100, width: 140, height: 60)
        button.center = self.view.center
        button.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(button)
        button.addTarget(self, action: "actionFrameWork", forControlEvents: .TouchUpInside)
        
        let fileLoadClient = LoadFileClient(startCache: "https://dn-heyue.qbox.me/HelloDy.framework.zip", success: { (result) in
            
            print("下载完成")
            
            let tempDocumentDirectory = NSTemporaryDirectory()
            let documentsPath = tempDocumentDirectory + "tempFramework.zip"
            let success = result.writeToFile(documentsPath, atomically: true)
            if success {
                
                let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                
                if paths.count > 0 {
                    
                    let documentDirectory = paths[0] + "/"
                    
                    let zip = ZipArchive()
                    
                    zip.UnzipOpenFile(documentsPath)
                    zip.UnzipFileTo(documentDirectory, overWrite: true)
                    
                    print("documentDirectory = \(documentDirectory)")
                    
                    //注入内存
                    AppDelegate.OnDlopenLoadAtPathAction1()
                }
            }
            
            }) { (statuscode, errordes) in
        }
        
        fileLoadClient.startCache()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func actionFrameWork() {
        
        let classType = NSClassFromString("HelloDyVC") as? UIViewController.Type
        if let type = classType {
            let my = type.init()
            self.navigationController?.pushViewController(my, animated: true)
        }
    }

}
