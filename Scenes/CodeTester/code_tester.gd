extends Node


func _ready() -> void:
    var d := {
        "1": "a",
        "2": "b",
        "3": "c"
    }

    for key: String in d:
        var value: String = d[key]
        print("key {%s} | value {%s}" % [key, value])