//
//  RepositoryListInteractorTests.swift
//  github-bestsTests
//
//  Created by Paulo Lourenço on 03/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

@testable import github_bests
@testable import PromiseKit
import Quick
import Nimble
import Cuckoo

class RepositoryListInteractorTests: QuickSpec {

    override func spec() {

        // MARK: - PromiseKit configuration

        PromiseKit.conf.Q.map = nil
        PromiseKit.conf.Q.return = nil
        
        // MARK: Tests

        describe("Requisição API de busca") {

            context("Faz a requisição da primeira pagina e retorna com sucesso", {

                let mockedWorker = RepositoryListWorker(dataSource: SearchAPIMock())
                let mockedPresenter = MockRepositoryListPresenter()

                stub(mockedPresenter) { (stub) in
                    when(stub.presentList()).thenDoNothing()
                    when(stub.presentLoading(screen: any())).thenDoNothing()
                    when(stub.stopLoading(screen: any())).thenDoNothing()
                    when(stub.presentError(error: any())).thenDoNothing()
                }
                let sut = RepositoryListInteractor()
                sut.worker = mockedWorker
                sut.presenter = mockedPresenter
                sut.fetchRepositories(next: false)

                it("O método presentList deve ser chamado uma vez", closure: {
                    verify(mockedPresenter, times(1)).presentList()
                })

                it("O método presentError não deve ser chamado nenhuma vez", closure: {
                    verify(mockedPresenter, never()).presentError(error: any())
                })

                it("O array repositoryList deve ter 20 itens", closure: {
                    expect(sut.repositoryList.count).to(equal(20))
                })
            })


            context("Quando faz requisição da segunda página e retorna com sucesso", {
                let searchAPIMock = SearchAPIMock()
                let mockedWorker = RepositoryListWorker(dataSource: searchAPIMock)
                let mockedPresenter = MockRepositoryListPresenter()


                stub(mockedPresenter) { (stub) in
                    when(stub.presentList()).thenDoNothing()
                    when(stub.presentLoading(screen: any())).thenDoNothing()
                    when(stub.stopLoading(screen: any())).thenDoNothing()
                    when(stub.presentError(error: any())).thenDoNothing()
                }
                let sut = RepositoryListInteractor()
                sut.worker = mockedWorker
                sut.presenter = mockedPresenter
                sut.repositoryList = searchAPIMock.generateRepositories(count: 20)
                sut.fetchMore(indexPath: IndexPath(row: 19, section: 0))


                it("O método presentList deve ser chamado uma vez", closure: {
                    verify(mockedPresenter, times(1)).presentList()
                })

                it("O método presentError não deve ser chamado nenhuma vez", closure: {
                    verify(mockedPresenter, never()).presentError(error: any())
                })

                it("O array repositoryList deve ter 40 itens", closure: {
                    expect(sut.repositoryList.count).to(equal(40))
                })
            })

            context("Faz a requisição da primeira pagina e retorna erro", {

                let mockedPresenter = MockRepositoryListPresenter()
                let mockedWorker = MockRepositoryListWorker(dataSource: SearchAPIMock())

                func a() {

                }

                stub(mockedPresenter) { (stub) in
                    when(stub.presentList()).thenDoNothing()
                    when(stub.presentLoading(screen: any())).thenDoNothing()
                    when(stub.stopLoading(screen: any())).thenDoNothing()
                    when(stub.presentError(error: any())).thenDoNothing()
                }

                stub(mockedWorker) { (stub) in
                    stub.getRepositories(request: any()).then({ (_) -> Promise<SearchResults<[Repository]>> in
                        return .init(error: HTTPClient.Errors.parseError)
                    })
                }

                let sut = RepositoryListInteractor()
                sut.worker = mockedWorker
                sut.presenter = mockedPresenter
                sut.fetchRepositories(next: false)

                it("O método presentList não deve ser chamado nenhuma vez", closure: {
                    verify(mockedPresenter, never()).presentList()
                })

                it("O método presentError deve ser chamado uma vez", closure: {
                    verify(mockedPresenter, times(1)).presentError(error: any())
                })

                it("O array repositoryList deve ter 0 itens", closure: {
                    expect(sut.repositoryList.count).to(equal(0))
                })
            })


        }

    }
}
