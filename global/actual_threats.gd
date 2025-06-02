extends Node

var schema_class

var threats = Dictionary()
var taken_measures = Dictionary()
var not_taken_measures = Dictionary()


func add_threats(new: Array):
	for t in new:
		if threats.has(t):
			threats[t] += 1
		else :
			threats[t] = 1


func remove_threats(old: Array):
	for t in old:
		if threats.has(t) && threats[t] > 1:
			threats[t] -= 1
		elif threats.has(t) && threats[t] == 1:
			threats.erase(t)


func set_schema_class(cls):
	schema_class = cls


func add_taken_measure(measure, comp = false):
	if comp:
		taken_measures[measure] = 2
	else:
		taken_measures[measure] = 1
	

func remove_taken_measure(measure):
	if taken_measures.has(measure):
		taken_measures.erase(measure)
