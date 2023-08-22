//
//  main.swift
//  Concurrency
//
//  Created by wooyoung on 2023/08/21.
//

import Foundation

/*
 parallel: 동시 작업
 async code: suspended and resumed later
 
 ex)
 actor를 이용해 mutable state에 안전하게 접근하기
 concurrency는 디버깅을 어렵게 한다.
 
 스위프트의 컨커런시는 컴파일 타임에서 문제를 해결하도록 돕는다
 
 concurrency = async + paralle code
 */

/*
 스위프트의 concurrency는 쓰레드와 직접적으로 상호작용 하지 않는다.
 비동기 함수는 재실행될 때 동일한 쓰레드에서 실행되는 것을 보장하지 않는다.
 
 swift concurrency 없이도 작업은 할 수 있지만 가독성이 떨어진다(callback)
 */

//  MARK: Defining and calling asynchronous functions

//  async method는 다른 작업이 끝날 때까지 지연될 수 있다.

func listPhotos(inGallery name: String) async -> [String] {
    
    let result = ["상영", "원영", "우영"] // 네트워크 작업이라 가정
    
    return result
}

//  await 키워드로 async 호출
//  await = possible suspension point
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]

/*
 특정 지점에서만 async 호출 가능
 
 - async 함수 내부(body)
 - static main() method (@main)
 - unstructured child task
 */

//  MARK: Asynchronous sequences

let handle = FileHandle.standardInput

//  for with await
//  사용하려면 AsyncSequence 프로토콜을 채택해야한다
for try await line in handle.bytes.lines {
    print(line)
}

//  MARK: Caling asynchronous functions in parallel

/*
 await으로 실행된 코드는 한번에 하나만 동작한다
 서로 순서가 무관한 경우 성능에 결함ㅇ ㅣ있다
 
 동시에 해도 되는 경우 async로 실행
 */

async let firstPhoto = listPhotos(inGallery: "first")
async let secondPhoto = listPhotos(inGallery: "second")
async let thirdPhoto = listPhotos(inGallery: "third")

//  세 작업은 병렬적으로 실행된다
let photos = await [firstPhoto, secondPhoto, thirdPhoto]

/*
 await은 순차적이다. 첫번째 함수가 다음 함수에 영향을 미친다.
 async let은 반대.
 */

//  MARK: Tasks and Task groups

/*
 Task: 프로그램이 비동기적으로 실행되는 단위.
 모든 async 함수는 task
 
 async let은 child task를 만든다
 
 task group을 만들고 child task를 그룹에 추가할 수 있다.
 우선순위와 취소 제어가 가능하다
 
 Task group안의 task는 동일한 parent task를 갖는다
 task와 task group 간의 관계가 명확해 structured concurreny라고 한다.
 
 TaskGroup에 자세한 정보
 */

await withTaskGroup(of: Data.self, body: { taskGroup in
    
})

//  MARK: Unstructured concurrency

/*
 스위프트는 unstructured concurrency도 지원한다.
 task group의 task와는 달리 parent task를 갖지 않는다
 
 필요한 작업을 관리하기는 쉬우나 정확성에 대한 책임을 내가 보장해야한다.
 
 자세한 정보는 Task에서
 */

let unstructuredConcurrency = Task {
    return await listPhotos(inGallery: "")
}

let result = await unstructuredConcurrency.value

//  MARK: Task cancellation


//  MARK: Actor

