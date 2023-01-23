
import SwiftUI

struct Fruit: Hashable {
    var name: String
}

enum Content: Hashable {
    case fruit(Fruit)
    case color
}

struct ContentView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    //リンク先に渡す値のみを決定
                    NavigationLink("リンゴ", value: Fruit(name: "リンゴ"))
                    NavigationLink("オレンジ", value: Fruit(name: "オレンジ"))
                    NavigationLink("バナナ", value: Fruit(name: "バナナ"))
                }
                
                Section {
                    //リンク先に渡す値のみを決定
                    NavigationLink("レッド", value: Color.red)
                    NavigationLink("ブルー", value: Color.blue)
                    NavigationLink("グリーン", value: Color.green)
                }
                
                Section {
                    NavigationLink("最後の画面", value: "最後")
                }
                Section {
                    Button(action: {
                        path = NavigationPath()
                        path.append(Fruit(name: "リンゴ"))
                        path.append(Color.blue)
                        path.append("最後の画面")
                    }) {
                        Text("遷移")
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
                LastView(text: text, path: $path)
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
    @Binding var path: NavigationPath
    var body: some View {
        Button(action: {
            path.removeLast()
            path.removeLast()
            path.removeLast()
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
