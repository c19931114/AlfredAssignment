//
//  Observable.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import Foundation

class Observable<T> {
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
