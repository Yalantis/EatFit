//
//  ViewController.swift
//  Pager
//
//  Created by aleksey on 08.05.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var eatFitController: EatFitViewController = EatFitViewController.controller()
    
    let objects: [ChartObject] = {
        var objects: [ChartObject] = []
        
        let filePath = NSBundle.mainBundle().pathForResource("Objects", ofType: "plist")
        let contents = NSArray(contentsOfFile: filePath!)! as Array
        
        for dictionary in contents {
            
            let color = UIColor(hexString: dictionary["color"] as! String)
            let percentage = dictionary["percentage"] as! Int
            let title = dictionary["title"] as! String
            let description = dictionary["description"] as! String
            let logoName = dictionary["logoName"] as! String
            let object: ChartObject = ChartObject(color: color, percentage: percentage, title: title, description: description, logoImage: UIImage(named: logoName)!)
            
            objects.append(object)
        }
        
        return objects
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eatFitController.dataSource = self
        eatFitController.view.frame = self.view.frame
        self.addChildViewController(eatFitController)
        self.view.tlk_addSubview(eatFitController.view, options: TLKAppearanceOptions.Overlay)
    }
}

extension ViewController: EatFitViewControllerDataSource {
    func numberOfPagesForPagingViewController(controller: EatFitViewController) -> Int {
        return objects.count
    }

    func chartColorForPage(index: Int, forPagingViewController: EatFitViewController) -> UIColor {
        return objects[index].color
    }

    func percentageForPage(index: Int, forPagingViewController: EatFitViewController) -> Int {
        return objects[index].percentage
    }

    func titleForPage(index: Int, forPagingViewController: EatFitViewController) -> String {
        return objects[index].title
    }

    func descriptionForPage(index: Int, forPagingViewController: EatFitViewController) -> String {
        return objects[index].description
    }

    func logoForPage(index: Int, forPagingViewController: EatFitViewController) -> UIImage {
        return objects[index].logoImage
    }

    func chartThicknessForPagingViewController(controller: EatFitViewController) -> CGFloat {
        return 15
    }
}
