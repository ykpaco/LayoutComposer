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
    case example1
    case example2
    case example3
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
        case .example1:
            layoutExample1()
        case .example2:
            layoutExample2()
        case .example3:
            layoutExample3()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func layoutExample1() {
        let view1 = makeItemView(title: "view1 halign: .Left, valign: .Top", color: UIColor.red)
        let view2 = makeItemView(title: "view2 halign: .Right, valign: .Bottom", color: UIColor.green)
        let view3 = makeItemView(title: "view3 halign: .Center, valign: .Center", color: UIColor.blue)

        contentView.applyLayout(Relative(), items: [
            $(view1, width: 200, height: 100, halign: .left, valign: .top),
            $(view2, width: 200, height: 100, halign: .right, valign: .bottom),
            $(view3, width: 200, height: 100, halign: .center, valign: .center)
        ])
    }

    fileprivate func layoutExample2() {
        let view1 = makeItemView(title: "view1 halign: .Left, height is not set", color: UIColor.red)
        let view2 = makeItemView(title: "view2 halign: .Right height is set", color: UIColor.green)
        let view3 = makeItemView(title: "view3 halign: .Center height is set", color: UIColor.blue)

        contentView.applyLayout(Relative(), items: [
           $(view1, width: 100, halign: .left),
           $(view2, width: 100, height: 100, halign: .right),
           $(view3, width: 100, height: 100, halign: .center)
        ])
    }

    fileprivate func layoutExample3() {
        let view1 = makeItemView(title: "view1 valign: .Top, width is not set", color: UIColor.red)
        let view2 = makeItemView(title: "view2 valign: .Center width is set", color: UIColor.green)
        let view3 = makeItemView(title: "view3 valign: .Bottom width is set", color: UIColor.blue)

        contentView.applyLayout(Relative(), items: [
            $(view1, height: 150, valign: .top),
            $(view2, width: 200, height: 150, valign: .center),
            $(view3, width: 200, height: 150, valign: .bottom)
            ])
    }
}
