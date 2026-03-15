class_name DaySummary
extends RefCounted

var easy_fish_number: int
var normal_fish_number: int
var hard_fish_number: int

@warning_ignore("shadowed_variable")
func _init(easy_fish_number: int, normal_fish_number: int, hard_fish_number: int) -> void:
	self.easy_fish_number = easy_fish_number
	self.normal_fish_number = normal_fish_number
	self.hard_fish_number = hard_fish_number

func increment_easy() -> DaySummary:
	return DaySummary.new(
		easy_fish_number + 1,
		normal_fish_number,
		hard_fish_number
	)

func increment_normal() -> DaySummary:
	return DaySummary.new(
		easy_fish_number,
		normal_fish_number + 1,
		hard_fish_number
	)

func increment_hard() -> DaySummary:
	return DaySummary.new(
		easy_fish_number,
		normal_fish_number,
		hard_fish_number + 1
	)
	
func increment_specific(type: Utils.FishType) -> DaySummary:
	if type == Utils.FishType.EASY:
		return increment_easy()
	if type == Utils.FishType.NORMAL:
		return increment_normal()
	return increment_hard()
