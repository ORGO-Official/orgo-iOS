//
//  Input.swift
//  orgo
//
//  Created by 김태현 on 2023/07/16.
//

protocol Input {
    
    associatedtype Input
    
    var input: Input { get }
    
    func bindInput()
    
}
