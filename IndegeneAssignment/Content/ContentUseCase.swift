import Foundation

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
            let contents = try dataSource.loadContent()
            return .idleState(ContentViewState(content: contents))
        } catch {
            return .errorState(ErrorViewState(error: error))
        }
    }
}
