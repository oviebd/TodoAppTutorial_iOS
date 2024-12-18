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


struct TodoData : Equatable{
    let id : String
    let title : String
    let date : Date
    let isCompleted : Bool
    let importanceTag : String
}

protocol DataLoader {
    func loadData(completion: @escaping ([TodoData]) -> Void)
}

class TodoDataLoader {
    
    let dataLoader : DataLoader
    
    init (dataLoader: DataLoader){
        self.dataLoader = dataLoader
    }

    func loadData(completion: @escaping ([TodoData]) -> Void){
        dataLoader.loadData(completion: completion)
    }
}

class TodoDataLoaderSpy : DataLoader {
   
    var todoList : [TodoData] = []
    
    func loadDataWIthSuccess(data: [TodoData]){
        todoList = data
    }
    
    func loadData(completion: @escaping ([TodoData]) -> Void){
      //  loader.loadData(completion: completion)
        completion(todoList)
    }
}

final class LoadToDoDataTests: XCTestCase {


    func test_loadData_LoadsDataAfterLoadSuccessfully(){
        let spy = TodoDataLoaderSpy()
        let sut = TodoDataLoader(dataLoader: spy)
        let todolist = GenerateDummyTodoList()
        var expectedData : [TodoData]?
       
      
        spy.loadDataWIthSuccess(data: todolist)
      
        sut.loadData(){ receivedData in
            expectedData = receivedData
        }
        XCTAssertEqual(todolist,expectedData )
    }
    
    
    // Marks : Helpers
    
    func GenerateDummyTodoList() -> [TodoData] {
        return [uniqueTodo(title:"Do study"),
                uniqueTodo(title: "Clean room"),
                uniqueTodo(title: "Prepare Food")]
    }
    
    func uniqueTodo(title : String, date : Date = Date(), isCompleted : Bool = false, importanceTag : String = "Important") -> TodoData{
        return TodoData(id: UUID().uuidString,
                        title: title,
                        date: date,
                        isCompleted: isCompleted,
                        importanceTag: importanceTag)
    }

}
