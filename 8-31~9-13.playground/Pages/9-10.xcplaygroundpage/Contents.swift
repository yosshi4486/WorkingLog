//: [Previous](@previous)

/*:
 # きょうの作業ログ　2020/09/10
 ・diffのAPIがたまにゲシュタルト崩壊するので確認
 */

let a = ["a", "b", "c", "d", "e"]
let b = ["b", "d", "c", "e", "a"]

for change in a.difference(from: b) {
    print(change)
}

/*
 remove(offset: 4, element: "a", associatedWith: nil)
 remove(offset: 1, element: "d", associatedWith: nil)
 insert(offset: 0, element: "a", associatedWith: nil)
 insert(offset: 3, element: "d", associatedWith: nil)
 */

for change in b.difference(from: a) {
    print(change)
}

/*
 remove(offset: 2, element: "c", associatedWith: nil)
 remove(offset: 0, element: "a", associatedWith: nil)
 insert(offset: 2, element: "c", associatedWith: nil)
 insert(offset: 4, element: "a", associatedWith: nil)
 */

//: 英語の語法のまま、aからbへのdiffが欲しいときは、b.difference(from: a)で良いのか。🙆‍♂️

/*:
 タプルの挙動を調べる。
 */

var fruits = ["Apple", "Banana", "Orange"]

for tupple in zip(fruits, [100]) {
    print(tupple)
}

fruits.removeSubrange(2...)
print(fruits)

//: [Next](@next)
