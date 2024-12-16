//
//  LoadToDoDataTests.swift
//  TodoCoreTests
//
//  Created by Habibur Rahman on 16/12/24.
//

import XCTest
@testable import TodoCore


//Do not load data at startup
//Load list after calling load function
//Categorized list based on data and completion type (today, upcoming, completed)


class TodoDataLoader {
     
    init(){
        
    }
    
}

class TodoDataLoaderStub {
    let loader : TodoDataLoader
    var messages: [String] = []
    init(loader: TodoDataLoader) {
        self.loader = loader
    }
    
    
 
}

final class LoadToDoDataTests: XCTestCase {

    // at startup no data will load
    func test_startup_donotLoadData(){
        let loader = TodoDataLoader()
        let sut = TodoDataLoaderStub(loader: loader)
        XCTAssertEqual(sut.messages.count, 0)
    }

}
