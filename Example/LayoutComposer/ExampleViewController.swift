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
        view.backgroundColor = UIColor.white
        
        let header = UIView()
        header.backgroundColor = UIColor.black
        
        let titleLabel = UILabel()
        titleLabel.text = headerTitle
        titleLabel.textColor = UIColor.white
        
        let backBtn = UIButton(type: .system)
        backBtn.setTitle("Back", for: UIControlState())
        backBtn.addTarget(self, action: #selector(ExampleViewController.onBackTapped(_:)), for: .touchUpInside)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.gray
        
        view.applyLayout(VBox(), items: [
            $(header, height: 65, layout: Relative(), items: [
                $(backBtn, halign: .left, marginTop: 20, marginLeft: 10),
                $(titleLabel, halign: .center, marginTop: 20)
            ]),
            $(contentView, flex: 1)
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onBackTapped(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }

    func makeItemView(title: String, color: UIColor) -> UIView {
        let retView = UIView()
        retView.backgroundColor = color

        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        
        retView.applyLayout(Fit(), item: $(titleLabel))
        return retView
    }
}
