//
//  VBoxExampleViewController.swift
//  LayoutComposer
//
//  Created by Yusuke Kawakami on 2015/08/22.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import LayoutComposer

enum FitExampleType: Int {
    case Example1
}

class FitExampleViewController: ExampleViewController {
    let exampleType: FitExampleType

    init(exampleType: FitExampleType, headerTitle: String) {
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
        let view1 = makeItemView(title: "view1", color: UIColor.redColor())

        contentView.applyLayout(Fit(), item: $(view1))
    }
}
