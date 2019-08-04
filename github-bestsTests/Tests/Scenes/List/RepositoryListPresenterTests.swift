//
//  RepositoryListPresenterTests.swift
//  github-bestsTests
//
//  Created by Paulo Lourenço on 04/08/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

@testable import github_bests
@testable import PromiseKit
import Quick
import Nimble

class MockRepositoryListDisplayLogic: RepositoryListDisplayLogic {

    var calledDisplayList = false
    var calledShowPaginationLoading = false
    var calledHidePaginationLoading = false
    var calledShowError = false
    var calledShowScreenLoading = false
    var calledHideScreenLoading = false

    func displayList() {
        calledDisplayList = true
    }

    func showPaginationLoading() {
        calledShowPaginationLoading = true
    }

    func hidePaginationLoading() {
        calledHidePaginationLoading = true
    }

    func showError(title: String?, message: String?) {
        calledShowError = true
    }

    func showScreenLoading() {
        calledShowScreenLoading = true
    }

    func hideScreenLoading() {
        calledHideScreenLoading = true
    }

}

class RepositoryListPresenterTests: QuickSpec {


    override func spec() {
        super.spec()

        // MARK: Tests


        describe("RepositoryListPresenter") {

            let mockedDisplayLogic = MockRepositoryListDisplayLogic()

            let sut = RepositoryListPresenter()
            sut.viewController = mockedDisplayLogic

            context("Checa se, quando os métodos são chamados pela Interactor, fazem a chamada na ViewController", {

                it("presentError deve chamar showError na ViewController", closure: {
                    sut.presentError(error: HTTPClient.Errors.invalidURL)
                    expect(mockedDisplayLogic.calledShowError).to(beTrue())
                })

                it("presentList deve chamar displayList na ViewController", closure: {
                    sut.presentList()
                    expect(mockedDisplayLogic.calledDisplayList).to(beTrue())
                })

                it("presentLoading com screen TRUE deve chamar showScreenLoading na ViewController", closure: {
                    sut.presentLoading(screen: true)
                    expect(mockedDisplayLogic.calledShowScreenLoading).to(beTrue())
                })

                it("presentLoading com screen FALSE deve chamar showScreenLoading na ViewController", closure: {
                    sut.presentLoading(screen: false)
                    expect(mockedDisplayLogic.calledShowPaginationLoading).to(beTrue())
                })

                it("stopLoading com screen TRUE deve chamar showScreenLoading na ViewController", closure: {
                    sut.stopLoading(screen: true)
                    expect(mockedDisplayLogic.calledHideScreenLoading).to(beTrue())
                })

                it("stopLoading com screen FALSE deve chamar showScreenLoading na ViewController", closure: {
                    sut.stopLoading(screen: false)
                    expect(mockedDisplayLogic.calledHidePaginationLoading).to(beTrue())
                })

            })
        }

    }


}
