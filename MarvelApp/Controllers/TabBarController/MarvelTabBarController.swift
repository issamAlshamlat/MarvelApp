//
//  MarvelTabBarController.swift
//  TottersTest
//
//  Created by Mhd Baher on 16/09/2022.
//

import UIKit

class MarvelTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupItems()
        setupTabBarUI()
    }
    
    private func setupTabBarUI() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            tabBar.tintColor = .maRed
            tabBar.unselectedItemTintColor = .gray
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
            tabBar.isTranslucent = false
            tabBar.barTintColor = .white
        }else {
            self.view.backgroundColor = .white
            tabBar.tintColor = .maRed
            tabBar.unselectedItemTintColor = .black
            tabBar.tintColor = .maRed
            tabBar.isTranslucent = false
            tabBar.barTintColor = .white
        }
    }
    
    private func setupItems() {

        for num in 0...1 {
            tabBar.items?[num].tag = num
            
            switch num {
            case 0:
                tabBar.items?[num].title = .tab_bar_home_button_title
                tabBar.items?[num].image = .home_unselected
                tabBar.items?[num].selectedImage = .home_selected
            case 1:
                
                tabBar.items?[num].title = .tab_bar_favourites_button_title
                tabBar.items?[num].image = .unliked
                tabBar.items?[num].selectedImage = .liked
            default:
                tabBar.items?[num].tag = -1
            }
        }
    }

}
