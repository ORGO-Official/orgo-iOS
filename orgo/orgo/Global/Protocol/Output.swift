//
//  Output.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

protocol Output {
    
    associatedtype Output
    
    var output: Output { get }
    
    func bindOutput()
    
}
