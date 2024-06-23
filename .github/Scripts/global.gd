extends Node

var gameStarted: bool
var paused = false

var playerBody: CharacterBody2D

var playerWeaponEquip = true

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
