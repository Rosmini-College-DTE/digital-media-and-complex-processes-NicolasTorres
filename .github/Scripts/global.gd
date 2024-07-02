extends Node

var gameStarted: bool
var paused = false

var playerBody: CharacterBody2D

var playerWeaponEquip = true

var current_damage_to_deal: int
var playerAlive: bool
var playerDamageZone: Area2D
var playerDamageAmount: int
var playerHitbox: Area2D
var playerDetectionHitbox: Area2D

var shadowDamageZone: Area2D
var shadowDamageAmount: int

var spikeDamageZone: Area2D
var spikeDamageAmount: int

var voidDamageZone: Area2D
var voidDamageAmount: int

var healZone: Area2D

var jellyDamageZone: Area2D
var jellyDamageAmount: int

var wormDamageZone: Area2D
var wormDamageAmount: int

var mushroomDamageZone: Area2D
var mushroomDamageAmount: int

var skeletonDamageZone: Area2D
var skeletonDamageAmount: int
