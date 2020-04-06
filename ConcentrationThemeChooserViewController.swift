//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by zhangye on 2020/4/6.
//  Copyright © 2020 zhangye. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let themes = [
        "Sport": "🏈🏀🏐⚾️⚽️🚴‍♀️🏄‍♀️🏏🤺",
        "Animal": "🦓🦒🦨😼🦔🦩🐊🐦🐬",
        "Faces": "💆‍♀️🥺🤩🤭🥳🥰☹️😳😁",
    ]

    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        }else if let cvc = lastSegueFromConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }else {
            // call function prepare
            performSegue(withIdentifier: "ChangeTheme", sender: sender)
        }
        
    }
    
    
    var  splitDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    var lastSegueFromConcentrationViewController: ConcentrationViewController?
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // use as to downcast
        if segue.identifier == "ChangeTheme" {
            if(self.navigationController == nil) {
                print("nil")
            }
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSegueFromConcentrationViewController = cvc
                }
            }
        }
    }
    

}
