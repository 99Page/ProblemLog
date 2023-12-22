//
//  IdentifeidArrayTests.swift
//  IdentifiedArrayTest
//
//  Created by wooyoung on 12/22/23.
//  Copyright © 2023 page. All rights reserved.
//

import XCTest
@testable import IdentifiedArrayStudy

final class IdentifeidArrayTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let viewModel = TodoViewModel()
        let lastTodo = TodoModel(title: "title")
        
        for _ in 0..<10000 {
            viewModel.identifiedTodos.append(.init(title: "title"))
        }
        viewModel.identifiedTodos.append(lastTodo)
       
        self.measure {
            viewModel.removeLastIdentifiedTodo()
        }
    }
    
    /*
     removeLast보다 id값으로 삭제하는 경우가 오히려 더 빠르다.
     */
    func test() {
        let viewModel = TodoViewModel()
        let lastTodo = TodoModel(title: "title")
        
        for _ in 0..<10000 {
            viewModel.identifiedTodos.append(.init(title: "title"))
        }
        viewModel.identifiedTodos.append(lastTodo)
        
        self.measure {
            viewModel.removeIdentifiedTodo(lastTodo)
        }
    }
    
    func testTraverseForLast() {
        let viewModel = TodoViewModel()
        let lastTodo = TodoModel(title: "title")
        
        for _ in 0..<10000 {
            viewModel.identifiedTodos.append(.init(title: "title"))
        }
        viewModel.identifiedTodos.append(lastTodo)
        
        self.measure {
            for _ in viewModel.identifiedTodos {
                
            }
        }
    }
    
    /*
     여러 테스트 결과 id값으로 인덱스를 조회하는데 성능적인 문제가 없다.
     */
    func testFindLastIndexByTodo() {
        let viewModel = TodoViewModel()
        let lastTodo = TodoModel(title: "title")
        
        for _ in 0..<10000 {
            viewModel.identifiedTodos.append(.init(title: "title"))
        }
        viewModel.identifiedTodos.append(lastTodo)
        
        self.measure {
            let index = viewModel.identifiedTodos.index(id: lastTodo.id)
        }
    }
}
