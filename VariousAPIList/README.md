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


## 条件と補足
- 指定がない限り、外部ライブラリは使わない。
- 細かな見た目は問わない（デザイン実装は目的ではない）。

---
## 最初のコード
以下のディレクトリに最初のテンプレートとなるコードを用意した。 <br>
これをベースに問題を解くこと。

---
## 問1.
Album と Photo はそれぞれ以下のようなデータを持っている。 

適当なサンプルデータをコード内に埋め込み、 `AlbumListPageView` と `PhotoListPageView` を実装せよ。
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
## 問2.
Album と Photo の一覧データを以下のAPIを呼んで取得して表示する、 `AlbumListPageView` と `PhotoListPageView` を実装せよ。

APIは各PageViewが表示される際に呼ぶこと。

|       | URL  |
|-------|------|
| Album | https://jsonplaceholder.typicode.com/albums |
| Photo | https://jsonplaceholder.typicode.com/photos?albumId=1 |

（Photo API はクエリフィルタしないとデータ量が無駄に多いのでクエリしている。）

### Hint
- API呼び出しには `URLSession` が使える。

