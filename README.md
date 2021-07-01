mecab-swift
===========

[![Swift 5.2](https://img.shields.io/badge/Swift-5.2-orange.svg)](https://swift.org)
![Platform Linux, macOS](https://img.shields.io/badge/Platforms-Linux%2C%20macOS-lightgray.svg)
[![CircleCI](https://circleci.com/gh/novi/mecab-swift.svg?style=svg)](https://circleci.com/gh/novi/mecab-swift)



MeCab wrapper for Swift.


```swift 
import MeCab

let m = Mecab()

let nodes = try! m.tokenize("太郎は次郎が持っている本を花子に渡した。")

for n in nodes.filter({ !$0.isBosEos }) {
    print(n.surface, n.features)
}      
``` 

```
太郎 ["名詞", "固有名詞", "人名", "名", "*", "*", "太郎", "タロウ", "タロー"]
は ["助詞", "係助詞", "*", "*", "*", "*", "は", "ハ", "ワ"]
次郎 ["名詞", "固有名詞", "人名", "名", "*", "*", "次郎", "ジロウ", "ジロー"]
が ["助詞", "格助詞", "一般", "*", "*", "*", "が", "ガ", "ガ"]
持っ ["動詞", "自立", "*", "*", "五段・タ行", "連用タ接続", "持つ", "モッ", "モッ"]
て ["助詞", "接続助詞", "*", "*", "*", "*", "て", "テ", "テ"]
いる ["動詞", "非自立", "*", "*", "一段", "基本形", "いる", "イル", "イル"]
本 ["名詞", "一般", "*", "*", "*", "*", "本", "ホン", "ホン"]
を ["助詞", "格助詞", "一般", "*", "*", "*", "を", "ヲ", "ヲ"]
花 ["名詞", "一般", "*", "*", "*", "*", "花", "ハナ", "ハナ"]
子 ["名詞", "接尾", "一般", "*", "*", "*", "子", "コ", "コ"]
に ["助詞", "格助詞", "一般", "*", "*", "*", "に", "ニ", "ニ"]
渡し ["動詞", "自立", "*", "*", "五段・サ行", "連用形", "渡す", "ワタシ", "ワタシ"]
た ["助動詞", "*", "*", "*", "特殊・タ", "基本形", "た", "タ", "タ"]
。 ["記号", "句点", "*", "*", "*", "*", "。", "。", "。"]
```

# Requirements

* Swift 5.2 or later (Linux and macOS)

## macOS

Install pkg-config `.pc`.

```sh
$ brew tap novi/tap
$ brew install novi/tap/cmecab
```

# Dependencies

* libmecab (only UTF8 version is supported.)

# License

MIT
