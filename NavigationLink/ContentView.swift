
import SwiftUI

struct Fruit: Hashable {
    var name: String
}

struct ContentView: View {
    @State private var path = NavigationPath() // 配列[]で管理する
    var body: some View {
        //path[]に何が入っているかで画面遷移を管理する
        NavigationStack(path: $path) {
            List {
                Section("フルーツ") {
                    //リンク先に渡す値のみを決定
                    NavigationLink("リンゴ", value: Fruit(name: "リンゴ"))
                    NavigationLink("オレンジ", value: Fruit(name: "オレンジ"))
                    NavigationLink("バナナ", value: Fruit(name: "バナナ"))
                }
                
                Section("カラ-") {
                    //リンク先に渡す値のみを決定
                    NavigationLink("ミント", value: Color.mint)
                    NavigationLink("淡い青", value: Color.teal)
                    NavigationLink("スカイブルー", value: Color.cyan)
                }
                Section {
                    Button(action: {
                        path = NavigationPath()
                        path.append(Fruit(name: "リンゴ"))
                        path.append(Color.cyan)
                        path.append("最後の画面")
                    }) {
                        Text("一気に画面遷移")
                    }
                }
            }
            .navigationDestination(for: Fruit.self) { fruit in
                FruitView(fruit: fruit)
            }
            .navigationDestination(for: Color.self) { color in
                color
            }
            .navigationDestination(for: String.self) { text in
                LastView(text: text, back: {
                    path.removeLast()
                    path.removeLast()
                    path.removeLast()
                })
            }
        }
    }
}

struct FruitView: View {
    let fruit: Fruit
    var body: some View {
        Text(fruit.name)
    }
}

struct LastView: View {
    let text: String
    let back: () -> Void
    var body: some View {
        Button(action: {
            back()
        }) {
            Text("最初の画面に戻る")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
