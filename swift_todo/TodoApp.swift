import SwiftUI

class Todo: Identifiable {
    let id = UUID()
    var task: String
    var isCompleted: Bool

    init(task: String, isCompleted: Bool) {
        self.task = task
        self.isCompleted = isCompleted
    }
}

struct TodoApp: View {
    @State var todos: [Todo] = []
    @State var newTodo = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New Todo", text: $newTodo)
                    Button(action: {
                        let todo = Todo(task: self.newTodo, isCompleted: false)
                        self.todos.append(todo)
                        self.newTodo = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                    }
                }
                        .padding()

                List {
                    ForEach(todos) { todo in
                        HStack {
                            Button(action: {
                                todo.isCompleted.toggle()
                            }) {
                                if todo.isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                } else {
                                    Image(systemName: "circle")
                                            .foregroundColor(.gray)
                                }
                            }
                            Text(todo.task)
                                    .strikethrough(todo.isCompleted)
                        }
                    }
                            .onDelete(perform: delete)
                }
                        .navigationBarTitle("To-Do List")
                        .navigationBarItems(trailing: EditButton())
            }
        }
    }

    func delete(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

struct TodoApp_Previews: PreviewProvider {
    static var previews: some View {
        TodoApp()
    }
}
