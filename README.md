# github-bests

Aplicativo que consulta API de pesquisar repositórios do GitHub.

Desenvolvido por Paulo Lourenço.

## Screenshot

<img src="https://i.imgur.com/gOqe3PD.png" height="400">

## Ferramentas e tecnologias utilizadas

- Xcode 10.3
- Swift 5
- CocoaPods
- Fastlane c/ Slather

## Arquitetura utilizada

Clean Swift (https://clean-swift.com/)

## Pods utilizados

#### Alamofire (https://github.com/Alamofire/Alamofire)
Para requisições HTTP.

#### SDWebImage (https://github.com/rs/SDWebImage)
Para carregar imagens e gerenciar cache.

#### PromiseKit (https://github.com/mxcl/PromiseKit)
Para trabalhar melhor com métodos assíncronos.

#### Cuckoo (https://github.com/Brightify/Cuckoo)
Para mockar e stubar classes no teste unitário.

#### OHHTTPStubs (https://github.com/AliSoftware/OHHTTPStubs)
Para stubar requisições HTTP no teste integrado.

#### KIF (https://github.com/kif-framework/KIF)
Para teste integrado.

#### iOSSnapshotTestCase (https://github.com/uber/ios-snapshot-test-case)
Para teste de snapshot.

#### Quick (https://github.com/Quick/Quick)
Para testes unitários.

#### Nimble (https://github.com/Quick/Nimble)
Para testes unitários.


## Instruções

- Dê `pod install` e abra o projeto pelo .xcworkspace.
- Os testes de snapshot foram gravados nos iPhones 8 e X, portanto, **rode o teste nesses devices/simuladores**.
- Para rodar a lane com Slather: `fastlane custom_lane`

## Observações

O stub das requisições HTTP está sendo feito na AppDelegate pois, pelo fato de o KIF rodar como teste unitário ao invés de teste de UI, não era possível stubar diretamente no `setUp()` dos testes, pois ao contrário dos testes de UI onde nós podemos executar o XCUIApplication a qualquer momento, no teste unitário a execução do app ocorre automaticamente e antes do `setUp()` de qualquer teste ser chamado, logo, o stub só ocorreria **APÓS** a chamada da API já ter sido feita.
