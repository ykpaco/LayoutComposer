//
//  VBoxExampleViewController.swift
//  LayoutComposer
//
//  Created by Yusuke Kawakami on 2015/08/22.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import LayoutComposer

enum NestExampleType: Int {
    case Example1
}

class NestExampleViewController: ExampleViewController {
    let exampleType: NestExampleType

    init(exampleType: NestExampleType, headerTitle: String) {
        self.exampleType = exampleType
        super.init(headerTitle: headerTitle)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func loadView() {
        super.loadView()
        switch exampleType {
        case .Example1:
            layoutExample1()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func layoutExample1() {
        let profileContainer = UIView()
        profileContainer.backgroundColor = UIColor.whiteColor()
        profileContainer.layer.cornerRadius = 5

        let icon = UIImageView(image: UIImage(named: "avatar.jpeg"))
        icon.layer.cornerRadius = 2
        
        let changeProfileBtn = UIButton.buttonWithType(.System) as! UIButton
        changeProfileBtn.setTitle("Update Profile", forState: .Normal)
        changeProfileBtn.layer.borderWidth = 1
        changeProfileBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        changeProfileBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        changeProfileBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        changeProfileBtn.layer.cornerRadius = 2
        
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.font = UIFont.systemFontOfSize(16)
        nameLabel.text = "YKPaco"
        
        let userIDLabel = UILabel()
        userIDLabel.textColor = UIColor.grayColor()
        userIDLabel.font = UIFont.systemFontOfSize(10)
        userIDLabel.text = "@ykpaco"
        
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.font = UIFont.systemFontOfSize(12)
        messageLabel.text = "Each layout pattern is able to contain other layout patterns as children and you can form camplicated layouts.\n" +
            "Auto Layout code written by LayoutComposer expresses the view hierarchy." +
        "It makes Auto Layout code very simple and intuitive"
        
        let followLabel = UILabel()
        followLabel.font = UIFont.systemFontOfSize(12)
        followLabel.text = "150 follows"
        followLabel.textColor = UIColor.darkGrayColor()
        
        let followerLabel = UILabel()
        followerLabel.font = UIFont.systemFontOfSize(12)
        followerLabel.text = "130 followers"
        followerLabel.textColor = UIColor.darkGrayColor()
        
        contentView.applyLayout(VBox(), items: [
            $(profileContainer, margins: (10, 10, 10, 10), layout: VBox(pack: .Fit, defaultMargins: (0, 10, 0, 10)), items: [
                $(nil, height: 50, marginTop: 10, layout: Relative(), items: [
                    $(icon, width: 50, height: 50, halign: .Left),
                    $(changeProfileBtn, width: 100, height: 20, halign: .Right, valign: .Top)
                ]),
                $(nameLabel, marginTop: 5),
                $(userIDLabel, marginTop: 5),
                $(messageLabel, marginTop: 5),
                $(nil, height: 30, layout: HBox(), items: [
                    $(followLabel),
                    $(followerLabel, marginLeft: 10)
                ])
            ])
        ])
    }


    /*
    private func layoutExample1() {
        let messageContainer = UIView()
        messageContainer.backgroundColor = UIColor.whiteColor()
        
        let icon = UIImageView(image: UIImage(named: "avatar.jpeg"))
        icon.layer.cornerRadius = 2

        let changeProfileBtn = UIButton.buttonWithType(.Custom) as! UIButton
        changeProfileBtn.layer.borderColor = UIColor.grayColor().CGColor
        changeProfileBtn.setTitle("Update Profile", forState: .Normal)
        
        let messageHeader = UIView()
        
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.font = UIFont.systemFontOfSize(16)
        nameLabel.text = "YKPaco"
        
        let userIDLabel = UILabel()
        userIDLabel.textColor = UIColor.grayColor()
        userIDLabel.font = UIFont.systemFontOfSize(10)
        userIDLabel.text = "@ykpaco"
        
        let dateLabel = UILabel()
        dateLabel.textColor = UIColor.grayColor()
        dateLabel.font = UIFont.systemFontOfSize(10)
        dateLabel.text = "2015/07/20"

        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.font = UIFont.systemFontOfSize(12)
        messageLabel.text = "Each layout pattern is able to contain other layout patterns as children and you can form camplicated layouts.\n" +
            "Auto Layout code written by LayoutComposer expresses the view hierarchy." +
            "It makes Auto Layout code very simple and intuitive"
        
        contentView.applyLayout(Fit(), items: [
            $(messageContainer, margins: (10, 10, 10, 10), layout: VBox(align: .Start), items: [
                $(icon, width: 50, height: 50, marginLeft: 10, marginTop: 10),
                $(nil, flex: 1, margins: (10, 10, 0, 10), layout: VBox(pack: .Fit), items: [
                    $(messageHeader, height: 16, layout: HBox(), items: [
                        $(nameLabel),
                        $(userIDLabel, marginLeft: 10)
                    ]),
                    $(messageLabel, marginTop: 10)
                    ])
                ])
            ])


        /*
        contentView.applyLayout(Fit(), items: [
            $(messageContainer, margins: (10, 10, 10, 10), layout: HBox(align: .Start), items: [
                $(icon, width: 50, height: 50, marginLeft: 10, marginTop: 10),
                $(nil, flex: 1, margins: (10, 10, 0, 10), layout: VBox(pack: .Fit), items: [
                    $(messageHeader, height: 16, layout: HBox(), items: [
                        $(nameLabel),
                        $(userIDLabel, marginLeft: 10)
                    ]),
                    $(messageLabel, marginTop: 10)
                ])
            ])
        ])
        */
        // add date label to right bottom of message header.
        messageHeader.applyLayout(Relative(), item: $(dateLabel, halign: .Right, valign: .Center))
    }
    */
}
