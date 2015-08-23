//
//  ExampleViewController.swift
//  LayoutComposer
//
//  Created by Yusuke Kawakami on 2015/08/22.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import LayoutComposer

class ExampleViewController: BaseViewController {
    let headerTitle: String
    var contentView: UIView!
    
    init(headerTitle: String) {
        self.headerTitle = headerTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        
        let header = UIView()
        header.backgroundColor = UIColor.blackColor()
        
        let titleLabel = UILabel()
        titleLabel.text = headerTitle
        titleLabel.textColor = UIColor.whiteColor()
        
        let backBtn = UIButton.buttonWithType(.System) as! UIButton
        backBtn.setTitle("Back", forState: .Normal)
        backBtn.addTarget(self, action: "onBackTapped:", forControlEvents: .TouchUpInside)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.lightGrayColor()
        
        view.applyLayout(VBox(), items: [
            $(header, height: 65, layout: Relative(), items: [
                $(backBtn, halign: .Left, marginLeft: 10, marginTop: 20),
                $(titleLabel, halign: .Center, marginTop: 20)
            ]),
            $(contentView, flex: 1)
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onBackTapped(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }

    func makeItemView(#title: String, color: UIColor) -> UIView {
        let retView = UIView()
        retView.backgroundColor = color

        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = .Center
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        
        retView.applyLayout(Fit(), item: $(titleLabel))
        return retView
    }
}
