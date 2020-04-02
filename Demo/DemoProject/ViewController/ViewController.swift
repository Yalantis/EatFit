//
//  ViewController.swift
//  EatFit Demo Project
//
//  Created by aleksey on 08.05.15.
//  Copyright (c) 2015 Aleksey Chernish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let eatFitController = EatFitViewController()
    
    let objects: [ChartObject] = {
        var objects: [ChartObject] = []
        
        let filePath = Bundle.main.path(forResource: "Objects", ofType: "plist")
        let contents = NSArray(contentsOfFile: filePath!)! as Array

        for dictionary in contents {
            let color = UIColor(hexString: dictionary["color"] as! String)
            let percentage = dictionary["percentage"] as! Int
            let title = dictionary["title"] as! String
            let description = dictionary["description"] as! String
            let logoName = dictionary["logoName"] as! String
            let logoImage = UIImage(named: logoName)!
            let object = ChartObject(color: color, percentage: percentage, title: title, description: description, logoImage: logoImage)
            
            objects.append(object)
        }
        
        return objects
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eatFitController.dataSource = self
        eatFitController.view.frame = view.frame
        addChild(eatFitController)
        view.yal_addSubview(eatFitController.view, options: .overlay)
    }
}

extension ViewController: EatFitViewControllerDataSource {
    
    func numberOfPagesForPagingViewController(_ controller: EatFitViewController) -> Int {
        return objects.count
    }

    func chartColorForPage(_ index: Int, forPagingViewController: EatFitViewController) -> UIColor {
        return objects[index].color
    }

    func percentageForPage(_ index: Int, forPagingViewController: EatFitViewController) -> Int {
        return objects[index].percentage
    }

    func titleForPage(_ index: Int, forPagingViewController: EatFitViewController) -> String {
        return objects[index].title
    }

    func descriptionForPage(_ index: Int, forPagingViewController: EatFitViewController) -> String {
        return objects[index].description
    }

    func logoForPage(_ index: Int, forPagingViewController: EatFitViewController) -> UIImage {
        return objects[index].logoImage
    }

    func chartThicknessForPagingViewController(_ controller: EatFitViewController) -> CGFloat {
        return 15
    }
}
