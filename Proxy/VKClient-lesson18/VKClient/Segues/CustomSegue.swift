//
//  CustomSegue.swift
//  VKClient
//
//  Created by Alex Larin on 21.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import Foundation
import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        guard let containerView = source.view.superview else { return }
        
        let containerViewFrame = containerView.frame
        let sourceViewTargetFrame = CGRect(x: 400,
                                           y: -containerViewFrame.height,
                                           width: source.view.frame.width,
                                           height: source.view.frame.height)
        let destinationViewTargetFrame = source.view.frame
        
        containerView.addSubview(destination.view)
        
        destination.view.frame = CGRect(x: -400,
                                        y: containerViewFrame.height,
                                        width: source.view.frame.width,
                                        height: source.view.frame.height)
        
        
        UIView
            .animate(withDuration: 0.5,
                     animations: {
                        self.source.view.frame = sourceViewTargetFrame
                        self.destination.view.frame = destinationViewTargetFrame
            }) { finished in
                self.source.present(self.destination,
                                    animated: false,
                                    completion: nil)
        }
    }
    
}
