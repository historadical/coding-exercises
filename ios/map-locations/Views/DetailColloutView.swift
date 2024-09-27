//
//  DetailCalloutView.swift
//  map-locations
//
//  Created by Nic on 9/26/24.
//

import UIKit
import SwiftUI

class DetailCalloutView: UIView {
    
    private let hostingController: UIHostingController<DetailCalloutContentView>
    
    init(location: Location) {
        hostingController = UIHostingController(rootView: DetailCalloutContentView(location: location))
        super.init(frame: .zero)
        
            // Remove background color to make callout background transparent
        hostingController.view.backgroundColor = .clear
        
            // Add the SwiftUI view to the UIKit view hierarchy
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hostingController.view)
        
            // Constraints to make the SwiftUI view fill the UIView
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
            // Set preferred content size for the callout
        let contentSize = hostingController.view.intrinsicContentSize
        self.frame = CGRect(origin: .zero, size: contentSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
