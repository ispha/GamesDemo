//
//  SingletoneClass.swift
//  GamesDemo
//
//  Created by Ahmed Hosny Sayed on 9/19/21.
//
import UIKit
class SingletoneClass: NSObject {
	static let sharedInstance = SingletoneClass()
	var tabbarView : UIView?
	var tabBarInnerView : DesignableUIView?
	var tabbarConstraintBotm : NSLayoutConstraint?
	var currentIndex = 1

	var tabBar = UITabBar()
	var pagerViewController = UIPageViewController()
}
