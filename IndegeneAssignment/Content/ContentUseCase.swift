import Foundation
import RxSwift

enum DataState {
    case idleState(ContentViewState)
    case errorState(ErrorViewState)
}

protocol ContentUseCase {
    func contentDataState() -> DataState
}

class IndengeContentUseCase: ContentUseCase {
    let dataSource: ContentDataSource
    
    init(dataSource: ContentDataSource) {
        self.dataSource = dataSource
    }
    
    func contentDataState() -> DataState {
        do {
            return .idleState(ContentViewState(content: try dataSource.loadContent()))
        } catch {
            return .errorState(ErrorViewState(error: error))
        }
    }
}
