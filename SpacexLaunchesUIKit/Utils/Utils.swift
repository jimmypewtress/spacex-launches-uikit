//
//  Utils.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import Foundation
import UIKit

class Utils {
    class func createVC<Type>(storyboard: Constants.Storyboards, vcId: String? = nil, initBlock: ((inout Type) -> Void)? = nil) -> Type {
        var vc: Type = self.createVC(storyboardId: storyboard.rawValue, vcId: vcId)
        
        initBlock?(&vc)
        
        return vc
    }
    
    class func createVC<Type>(storyboardId: String, vcId: String? = nil) -> Type {
        let type = Type.self
        let bundle = Bundle(for: type as! AnyClass)
        let storyboard = UIStoryboard.init(name: storyboardId, bundle: bundle)
        let vcId = vcId ?? String(describing: type)
        let vc = storyboard.instantiateViewController(withIdentifier: vcId)
        
        return vc as! Type
    }
}
