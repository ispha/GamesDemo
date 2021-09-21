//
//  NursingPagerViewController.swift
//  careMatePatient
//
//  Created by ispha on 9/30/20.
//  Copyright © 2020 khabeer. All rights reserved.
//

import UIKit

class HomePagerViewController: UIPageViewController , UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    var pageControl = UIPageControl()
    
    // MARK: UIPageViewControllerDataSource

    // var orderedViewControllers = [UIViewController]()
    private lazy var firstVC: GamesListViewController = {
		return  GamesListViewController(nibName: GamesListViewController.nibName(), bundle: nil)
      }()
    private lazy var secondtVC: FavouritesViewController = {
		return FavouritesViewController(nibName: FavouritesViewController.nibName(), bundle: nil)
      }()

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [firstVC,
                secondtVC]
    }()
    
   
	override func viewDidLoad() {
		super.viewDidLoad()

		self.dataSource = self
		self.delegate = self

		if let firstViewController = orderedViewControllers.first {
			setViewControllers([firstViewController],
							   direction: .forward,
							   animated: false,
							   completion: nil)
		}

		NotificationCenter.default.addObserver(self,
											   selector: #selector(self.refreshNow),
											   name: NSNotification.Name(rawValue: "refreshNow"),
											   object: nil)
		// configurePageControl()
		// Do any additional setup after loading the view.
		self.disableSwipeGesture()
	}
    @objc func refreshNow(_ notif: NSNotification){
        let newIndex =  notif.userInfo?["new_index"] as? Int
        //pageControl.currentPage = newIndex!
         let firstViewController = orderedViewControllers[newIndex!]
            setViewControllers([firstViewController],
                               direction: newIndex! > SingletoneClass.sharedInstance.currentIndex ? .reverse : .forward,
                               animated: true ,
                               completion: nil)
        SingletoneClass.sharedInstance.currentIndex = newIndex!
        
        
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 100,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
   
    
    
    // MARK: Delegate methords
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
         let pageContentViewController = pageViewController.viewControllers![0]
      /*  SingletoneClass.sharedInstance.faseelSegentedControl.currentState = orderedViewControllers.index(of: pageContentViewController)!
      */
		self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
    }
    
    // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
       
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        
        let nextIndex = viewControllerIndex + 1
     
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    
    
}



