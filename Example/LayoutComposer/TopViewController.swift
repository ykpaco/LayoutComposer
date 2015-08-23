//
//  TopViewController.swift
//  LayoutComposer
//
//  Created by Yusuke Kawakami on 08/22/2015.
//  Copyright (c) 2015 Yusuke Kawakami. All rights reserved.
//

import UIKit
import LayoutComposer

class TopViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func loadView() {
        doLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func doLayout() {
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()

        let header = UIView()
        header.backgroundColor = UIColor.blackColor()

        let titleLabel = UILabel()
        titleLabel.text = "LayoutComposer Examples"
        titleLabel.textColor = UIColor.whiteColor()

        let scrollView = UIScrollView()

        view.applyLayout(VBox(), items: [
            $(header, height: 65, layout: Relative(), item:
                $(titleLabel, halign: .Center, marginTop: 20)
            ),
            $(scrollView, flex: 1, layout: VBox(align: .Center, pack: .Fit, defaultMargins: (10, 0, 0, 0)), items: [
                $(makeButton(title: "VBox Basic", action: "onVBoxExampleTapped:", tag: VBoxExampleType.Basic.rawValue)),
                $(makeButton(title: "VBox Margin", action: "onVBoxExampleTapped:", tag: VBoxExampleType.Margin.rawValue)),
                $(makeButton(title: "VBox Flex Height", action: "onVBoxExampleTapped:", tag: VBoxExampleType.Flex.rawValue)),
                $(makeButton(title: "VBox Align Start(Left)", action: "onVBoxExampleTapped:", tag: VBoxExampleType.AlignStart.rawValue)),
                $(makeButton(title: "VBox Align End(Right)", action: "onVBoxExampleTapped:", tag: VBoxExampleType.AlignEnd.rawValue)),
                $(makeButton(title: "VBox Align Center", action: "onVBoxExampleTapped:", tag: VBoxExampleType.AlignCenter.rawValue)),
                $(makeButton(title: "VBox Align Stretch", action: "onVBoxExampleTapped:", tag: VBoxExampleType.AlignStretch.rawValue)),
                $(makeButton(title: "VBox Align Each Component", action: "onVBoxExampleTapped:", tag: VBoxExampleType.AlignEachComponent.rawValue)),
                $(makeButton(title: "VBox Pack Start(Top)", action: "onVBoxExampleTapped:", tag: VBoxExampleType.PackStart.rawValue)),
                $(makeButton(title: "VBox Pack End(Bottom)", action: "onVBoxExampleTapped:", tag: VBoxExampleType.PackEnd.rawValue)),
                $(makeButton(title: "VBox Pack Center", action: "onVBoxExampleTapped:", tag: VBoxExampleType.PackCenter.rawValue)),
                $(makeButton(title: "VBox Pack Fit", action: "onVBoxExampleTapped:", tag: VBoxExampleType.PackFit.rawValue)),

                $(makeButton(title: "HBox Basic", action: "onHBoxExampleTapped:", tag: HBoxExampleType.Basic.rawValue)),
                $(makeButton(title: "HBox Margin", action: "onHBoxExampleTapped:", tag: HBoxExampleType.Margin.rawValue)),
                $(makeButton(title: "HBox Flex Width", action: "onHBoxExampleTapped:", tag: HBoxExampleType.Flex.rawValue)),
                $(makeButton(title: "HBox Align Start(Top)", action: "onHBoxExampleTapped:", tag: HBoxExampleType.AlignStart.rawValue)),
                $(makeButton(title: "HBox Align End(Bottom)", action: "onHBoxExampleTapped:", tag: HBoxExampleType.AlignEnd.rawValue)),
                $(makeButton(title: "HBox Align Center", action: "onHBoxExampleTapped:", tag: HBoxExampleType.AlignCenter.rawValue)),
                $(makeButton(title: "HBox Align Stretch", action: "onHBoxExampleTapped:", tag: HBoxExampleType.AlignStretch.rawValue)),
                $(makeButton(title: "HBox Align Each Component", action: "onHBoxExampleTapped:", tag: HBoxExampleType.AlignEachComponent.rawValue)),
                $(makeButton(title: "HBox Pack Start(Left)", action: "onHBoxExampleTapped:", tag: HBoxExampleType.PackStart.rawValue)),
                $(makeButton(title: "HBox Pack End(Right)", action: "onHBoxExampleTapped:", tag: HBoxExampleType.PackEnd.rawValue)),
                $(makeButton(title: "HBox Pack Center", action: "onHBoxExampleTapped:", tag: HBoxExampleType.PackCenter.rawValue)),
                $(makeButton(title: "HBox Pack Fit", action: "onHBoxExampleTapped:", tag: HBoxExampleType.PackFit.rawValue)),
                
                $(makeButton(title: "Relative 1", action: "onRelativeExampleTapped:", tag: RelativeExampleType.Example1.rawValue)),
                $(makeButton(title: "Relative 2", action: "onRelativeExampleTapped:", tag: RelativeExampleType.Example2.rawValue)),
                $(makeButton(title: "Relative 3", action: "onRelativeExampleTapped:", tag: RelativeExampleType.Example3.rawValue))
            ])
        ])
    }

    private func makeButton(#title: String, action: Selector, tag: Int) -> UIButton {
        let button = UIButton.buttonWithType(.System) as! UIButton
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        button.tag = tag
        return button
    }

    func onVBoxExampleTapped(sender: UIButton) {
        if let title = sender.titleForState(.Normal),
            exampleType = VBoxExampleType(rawValue: sender.tag)
        {
            let vc = VBoxExampleViewController(exampleType: exampleType, headerTitle: title)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func onHBoxExampleTapped(sender: UIButton) {
        if let title = sender.titleForState(.Normal),
            exampleType = HBoxExampleType(rawValue: sender.tag)
        {
            let vc = HBoxExampleViewController(exampleType: exampleType, headerTitle: title)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func onRelativeExampleTapped(sender: UIButton) {
        if let title = sender.titleForState(.Normal),
            exampleType = RelativeExampleType(rawValue: sender.tag)
        {
            let vc = RelativeExampleViewController(exampleType: exampleType, headerTitle: title)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
