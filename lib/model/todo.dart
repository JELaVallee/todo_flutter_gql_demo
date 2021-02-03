class Todo {
  String _id;
  String _name;
  String _description;
  bool _completed;

  // Default constructor
  Todo(this._id, this._name, this._completed);

  // Obligatory getter/setters
  getId() => this._id;
  setId(id) => this._id = id;
  getName() => this._name;
  setName(name) => this._name = name;
  getDescription() => this._description;
  setDescription(description) => this._description = description;
  isCompleted() => this._completed;
  setCompleted(completed) => this._completed = completed;
}
