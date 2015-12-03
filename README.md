EatFit
--------------

[![Yalantis](https://raw.githubusercontent.com/Yalantis/PullToMakeSoup/master/PullToMakeSoupDemo/Resouces/badge_dark.png)](http://Yalantis.com/?utm_source=github)

Check this [article on our blog](https://yalantis.com/blog/eat-drink-track-how-we-created-eat-fit-animation-inspired-by-google-fit/). 

![Preview](https://yalantis.com/media/content/ckeditor/2015/09/30/charts-animation.gif)

Purpose
--------------
Eat fit is a component for attractive data representation inspired by Google Fit. It is based on PageViewController, interface for customization is implemented in UITableViewDataSource style.

Supported OS & SDK Versions
-----------------------------

The component is implemented in Swift 2.0

* Supported build target - iOS 9.0 (Xcode 7)


ARC Compatibility
------------------

EatFit requires ARC. 

Thread Safety
--------------

EatFit is subclassed from UIView and - as with all UIKit components - it should only be accessed from the main thread. You may wish to use threads for loading or updating EatFit contents or items, but always ensure that once your content has loaded, you switch back to the main thread before updating the EatFit.

Installation
--------------

To install manually the EatFit component in an app, drag EatFit folder with all contents into your project. Use 
EatFitViewController as any other view controller in your app. Setup is done via data source pattern. EatFitViewController's data source must adopt protocol EatFitViewControllerDataSource


Memory issues
--------------
Inside the component pages are reused just like cells in UITableView. There are no more than 3 pages exist in memory at any moment no matter how many pages the component shows.

Properties
--------------

The EatFit has following properties:
```swift
	weak var dataSource: EatFitViewControllerDataSource!
```

Methods
--------------

The EatFitViewController class has the following methods:
```swift
	func reloadData()
```
This reloads all the component from the dataSource and refreshes the display.

Data source protocol
---------------
The EatFitViewControllerDataSource protocol has the following methods:
```swift
    func numberOfPagesForPagingViewController(controller: EatFitViewController) -> Int
```
Returns the number of pages in the EatFit view controller.
```swift
    func chartColorForPage(index: Int, forPagingViewController controller: EatFitViewController) -> UIColor
```
Returns the tint color for specific page. Tint color defines the chart color and logo color.
```swift
    func percentageForPage(index: Int, forPagingViewController controller: EatFitViewController) -> Int
```
Returns the percentage that defines displayed value of the percentage label and the graphic chart.
```swift
    func titleForPage(index: Int, forPagingViewController controller: EatFitViewController) -> String
```
Returns the title that is displayed at the top of each page.
```swift
    func descriptionForPage(index: Int, forPagingViewController controller: EatFitViewController) -> String
```
Returns the description that is displayed at the bottom of each page.
```swift
    func logoForPage(index: Int, forPagingViewController controller: EatFitViewController) -> UIImage
```
Returns the image for specific page. Actual color of image doesn't matter, it will be colored with page tint color. Perhaps keep in mind that image must be png with opacity.

```swift
    func chartThicknessForPagingViewController(controller: EatFitViewController) -> CGFloat
```
Returns chart thickness in points. It is applied for all pages.

Release Notes
----------------

Version 1.0

- Release version.
 
Let us know!
----------------

We’d be really happy if you send us links to your projects where you use our component. Just send an email to github@yalantis.com And do let us know if you have any questions or suggestion regarding the animation. 

P.S. We’re going to publish more awesomeness wrapped in code and a tutorial on how to make UI for iOS (Android) better than better. Stay tuned!

License
----------------

    The MIT License (MIT)

    Copyright © 2015 Yalantis

    Permission is hereby granted free of charge to any person obtaining a copy of this software and associated documentation files (the "Software") to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.

