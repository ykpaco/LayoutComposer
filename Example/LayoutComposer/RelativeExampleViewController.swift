//
//  VBoxExampleViewController.swift
//  LayoutComposer
//
//  Created by Yusuke Kawakami on 2015/08/22.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import LayoutComposer

enum RelativeExampleType: Int {
    case Example1
    case Example2
    case Example3
}

class RelativeExampleViewController: ExampleViewController {
    let exampleType: RelativeExampleType

    init(exampleType: RelativeExampleType, headerTitle: String) {
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
        case .Example2:
            layoutExample2()
        case .Example3:
            layoutExample3()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func layoutExample1() {
        let view1 = makeItemView(title: "view1 halign: .Left, valign: .Top", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2 halign: .Right, valign: .Bottom", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3 halign: .Center, valign: .Center", color: UIColor.blueColor())

        contentView.applyLayout(Relative(), items: [
           $(view1, halign: .Left, valign: .Top, width: 200, height: 100),
           $(view2, halign: .Right, valign: .Bottom, width: 200, height: 100),
           $(view3, halign: .Center, valign: .Center, width: 200, height: 100)
        ])
    }

    private func layoutExample2() {
        let view1 = makeItemView(title: "view1 halign: .Left, height is not set", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2 halign: .Right height is set", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3 halign: .Center height is set", color: UIColor.blueColor())

        contentView.applyLayout(Relative(), items: [
           $(view1, halign: .Left, width: 100),
           $(view2, halign: .Right, width: 100, height: 100),
           $(view3, halign: .Center, width: 100, height: 100)
        ])
    }

    private func layoutExample3() {
        let view1 = makeItemView(title: "view1 valign: .Top, width is not set", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2 valign: .Center width is set", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3 valign: .Bottom width is set", color: UIColor.blueColor())

        contentView.applyLayout(Relative(), items: [
            $(view1, valign: .Top, height: 150),
            $(view2, valign: .Center, height: 150, width: 200),
            $(view3, valign: .Bottom, height: 150, width: 200)
            ])
    }
}
