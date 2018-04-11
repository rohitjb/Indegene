import Foundation
import RxSwift

protocol ContentUseCase {
    func contentViewState() -> Observable<ContentViewState>
}

class IndengeContentUseCase: ContentUseCase {
    let dataSource: ContentDataSource
    
    init(dataSource: ContentDataSource) {
        self.dataSource = dataSource
    }
    
    func contentViewState() -> Observable<ContentViewState> {
        
    }
}
