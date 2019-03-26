/** Matthew Chastain, Justin Grabowski, Kevin Kelly, Jonathan Middleton
 *  CS298 Spring 2019 Team CGKM 
 * 
 * Provided AS IS. No warranties expressed or implied. Use at your own risk.
 */

import './../model/task.dart';
import './../util/databaseHelper.dart';
import 'package:uuid/uuid.dart';

class Arc 
{
  //in flutter, underscrore denotes private members
  String _aid;
  String _uid;
  String _title;
  String _description;
  String _parentArc;
  List<Task> _tasks;

  //constructor
  Arc(this._aid, this._uid, this._title, this._description, this._parentArc);

  // Defines a user map.  Helps with moving info betwen the db
  //   and the app
  Arc.map(dynamic obj)
  {
    _aid = obj["aid"];
    _uid = obj["uid"];
    _title = obj["title"];
    _description = obj["description"];
    _parentArc = obj["parentarc"];
  }

  //getters
  String get aid => _aid;
  String get uid => _uid;
  String get title => _title;
  String get description => _description;
  String get parentarc => _parentArc;

  // Puts object data onto a user map
  Map<String, dynamic> toMap()
  {
    var map = new Map<String, dynamic>();
    map["uid"] = _uid;
    map["title"] = _title;
    map["description"] =_description;
    map["parentarc"] =_parentArc;

    if (aid != null) {
      map["aid"] = _aid;
    }
    return map;
  }

  // Puts user map data into a user object
  Arc.fromMap(Map<String, dynamic> map)
  {
    _aid = map["aid"];
    _uid = map["uid"];
    _title = map["title"];
    _description = map["description"];
    _parentArc = map["parentarc"];
  }


/*---------------Member Functions-------------*/


  /*
  *Task addTask ( String title, {String description = null, 
  * DateTime dueDate = null, String location = null })
  *Parameter 1: title represents the title of the Task
  *Parameter 2: description is the information that describes the 
  * task objective. This is null by default
  *Parameter 3: dueDate is the date when the task should be completed by.
  * This is null by default
  *Parameter 4: location is where the task takes place. This is null by default
  *Return: Returns the created task
  *Description: The parameters supply needed information to create a Task within
  * the SQLite database with the exception of the ID. This ID needs to be 
  * generated with a UUID. This data is sent to the SQLite database to be
  * inserted into the task table. If successfully inserted the data should be
  * used to create a task object. That task object should then be added to the
  * list of tasks belonging to the Arc which called the instance method.
  */
  Task addTask ( String title, {String description = null, DateTime dueDate = null, String location = null })
  {
    var uuid = new Uuid();
    Task task = new Task(uuid.v4(), this._aid, title, description, dueDate.toString(), location );
   
    //add the new task to the list of tasks belonging to this arc
    _tasks.add(task);
    
    //insert new task into db
    DatabaseHelper.insertTask(task);
    return task;
  }

}