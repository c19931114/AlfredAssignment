//
//  RootViewModel.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import Foundation

class RootViewModel {
    
    var layout: Observable<Layout>
    
    init() {
        self.layout = Observable(.list)
    }
    
    
}
