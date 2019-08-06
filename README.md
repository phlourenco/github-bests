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
Para carregar imagens pela URL e gerenciamento de cache.

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

Dê `pod install` e abra o projeto pelo .xcworkspace.

## Observações

### Testes unitários e snapshot

Os testes de snapshot foram gravados nos iPhones 8 e X, portanto, **rode o teste nesses devices/simuladores**.
