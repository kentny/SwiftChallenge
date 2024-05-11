# VariousAPIList
## Overview
一般公開されているサンプルWEB APIから取得したデータをSwiftUIを使って表示する問題。

各問題を通じて以下のような見た目のアプリを作る。

![Demo](https://github.com/kentny/SwiftChallenge/blob/main/image/demo.gif?raw=true)



## View名
| View              | 目的             |
|-------------------|----------------|
| TopPageView       | 起動時に表示される画面    |
| AlbumListPageView | Album一覧を表示する画面 |
| PhotoListPageView | Photo一覧を表示する画面 |


## 制約と補足
- 外部ライブラリは使わない。
- 細かな見た目は問わない（デザイン実装は目的ではない）。

---
## 最初のコード
以下のディレクトリに最初のテンプレートとなるコードを用意した。 <br>
これをベースに問題を解くこと。

[Template Project](https://github.com/kentny/SwiftChallenge/tree/main/VariousAPIList/0_Template/VariousAPIList)

---
## 問1. 基本構造の実装
### 難易度：⭐️
Album と Photo はそれぞれ以下のようなデータを持っている。 

適当なサンプルデータをコード内に埋め込み、 `AlbumListPageView` と `PhotoListPageView` を実装せよ。<br>
（WEB APIはこの時点では呼ばない）

`PhotoListPageView` に表示する画像は `thumbnailUrl` を使うこと。

**Album**

| Key    | Type   |
|--------|--------|
| userId | Long   |
| id     | Long   |
| title  | String |


**Photo**

| Key          | Type   |
|--------------|--------|
| albumId      | Long   |
| id           | Long   |
| title        | String |
| url          | String |
| thumbnailUrl | String |

### Hint
- `AsyncImage` を使うことでURLから直接画像を表示できる。
---
## 問2. API呼び出しの実装
### 難易度：⭐️
Album と Photo の一覧データを以下のAPIを呼んで取得して表示する、 `AlbumListPageView` と `PhotoListPageView` を実装せよ。

- APIは各PageViewが表示される際に呼ぶこと。
- ViewModel層を使うこと。

|       | URL  |
|-------|------|
| Album | https://jsonplaceholder.typicode.com/albums |
| Photo | https://jsonplaceholder.typicode.com/photos?albumId=1 |

（Photo API はクエリフィルタしないとデータ量が無駄に多いのでクエリしている。）

### Hint
- API呼び出しには `URLSession` が使える。

---
## 問3. API Clientの実装
### 難易度：⭐️️⭐️️
API呼び出しは頻繁に使う機能のため簡易的なAPI Clientを新規実装したい。

API Client は以下の制約を設けて良い。

- GET method のみのサポート。
- レスポンスデータは JSON である想定。
- クエリパラメータはサポート。
- ヘッダーカスタマイズはサポート。

API Client はOpen-Closeの原則を意識して以下のような作りとする。

`// TODO: ここを実装する` を実装せよ。

また、実装したAPI Clientを使ってデータを取得し画面表示するようにリファクタリングせよ。

（必要に応じて、 `// TODO` 部分以外も実装せよ。）

```swift
import Foundation

enum HttpMethod: String {
    case GET
}

protocol APIRequest {
    associatedtype ResponseType: Decodable

    var endpoint: String { get }
    var method: HttpMethod { get }
    var headers: [String: String] { get }
    var baseURL: URL? { get }
    var parameters: [String: String] { get }
}

struct GetAlbumsRequest: APIRequest {
    // TODO: ここを実装する
}

struct GetPhotosRequest: APIRequest {
    // TODO: ここを実装する
}

protocol APIClient {
    func executeWithCompletion<T: APIRequest>(_ request: T, completion: @escaping (T.ResponseType?, Error?) -> Void)
}

class APIClientImpl: APIClient {
    func executeWithCompletion<T>(_ request: T, completion: @escaping (T.ResponseType?, (any Error)?) -> Void) where T: APIRequest {
        // TODO: ここを実装する
    }
}
```

### Hint
- `APIClientImpl` 内では `URLSession` を直接使って良い。<br>つまりテスト可能な状態にする必要はない。

---
## 問4. Lazy Loading
### 難易度：⭐️️
`PhotoListPageView` では `albumId=1` の条件を入れることでパフォーマンスの劣化を防いでいる。

だが、パフォーマンスを劣化せずに他の `albumId` のデータも表示させたい。

Lazy Loadingとは何かを調べ、Lazy Loadingを実装することで、 `albumId` が `2...4`のデータも表示せよ。

---
## 問5. URLSession Spy
### 難易度：⭐️️⭐️️
`APIClientImpl` のなかで `URLSession` を使ってWEB APIを呼んでいる。

`APIClientImpl` をテストするために、 `URLSession` をTestDoublesで置き換えたい。

依存性注入によって、`URLSession` の利用をテスト可能にし、 `URLSession` の Spy を作成せよ。

---
## 問6. 様々なAPI Client
### 難易度：⭐️️⭐️️
Swiftには非同期処理を実行するためのメソッドの書き方が複数存在する。

自作するAPI Clientにはそれらの全ての書き方をサポートさせたい。

`APIClient`プロトコルを以下のように変更する。

これに準拠する `APIClientImpl` を実装せよ。

また、それぞれの書き方の長所・短所を述べよ。

```swift
protocol APIClient {
    func executeWithCompletion<T: APIRequest>(_ request: T, completion: @escaping (T.ResponseType?, Error?) -> Void)
    func executeWithFuture<T: APIRequest>(_ request: T) -> Future<T.ResponseType, Error>
    func executeWithAsyncThrows<T: APIRequest>(_ request: T) async throws -> T.ResponseType
    func executeWithAsyncResult<T: APIRequest>(_ request: T) async -> Result<T.ResponseType, Error>
}
```

---
## 問7. Reusable Listの実装
### 難易度：⭐️️⭐️️⭐️️
`AlbumListPageView`と`PhotoListPageView`を個別のViewとして作ったが、共通点が多いので共通処理は共通化したい。

具体的には、`AlbumListPageView`と`PhotoListPageView`を以下の３つのViewに分解するアイデアを思いついた。

| View              | 役割                   |
|-------------------|----------------------|
| ListPageView      | リスト画面の描画。            |
| AlbumListItemView | リスト画面の各行のAlbum情報の描画。 |
| PhotoListItemView | リスト画面の各行のPhoto情報の描画。 |

Open-Closeの原則を意識し、今後他の種類の項目をリスト表示したい場合（ex. `TodoListItemView` の追加など）でも `ListPageView` には手を加えずに追加できるように実装せよ。

---
## 問8. Image Cache
### 難易度：⭐️️⭐️️⭐️️
現在`AsyncImage` を使ってPhotoリストの画像を表示している。

だが、`AsyncImage` は画像をキャッシュしないためページ表示のたびに画像をダウンロードしていてパフォーマンスが悪い。

この問題を解決するために画像データをキャッシュしたい。

以下の要件を満たすViewパーツを自作せよ。

- 同じURLの画像データはキャッシュし使い回せるようにする。
- 一定時間経過したらキャッシュデータは破棄して次回は再度ダウンロードする。
