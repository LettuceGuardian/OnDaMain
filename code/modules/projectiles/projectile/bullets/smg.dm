// 4.6x30mm (Autorifles)

/obj/projectile/bullet/c46x30mm
	name = "4.6x30mm bullet"
	damage = 20
	armour_penetration = 10
	speed = BULLET_SPEED_PDW

/obj/projectile/bullet/c46x30mm/ap
	name = "4.6x30mm armor-piercing bullet"
	damage = 18
	armour_penetration = 40
	embed_type = null
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/incendiary/c46x30mm
	name = "4.6x30mm incendiary bullet"
	damage = 10
	fire_stacks = 1

/obj/projectile/bullet/c46x30mm/salt
	name = "4.6x30mm saltshot bullet"
	damage = 0
	stamina = 20
	embed_type = null
	sharpness = NONE
	speed_mod = BULLET_SPEED_RUBBER_MOD

/obj/projectile/bullet/c46x30mm/rub
	name = "4.6x30mm rubber bullet"
	damage = 4
	stamina = 20
	armour_penetration = -10
	embed_type = null
	sharpness = NONE
	speed_mod = BULLET_SPEED_RUBBER_MOD

// .27-54 Cesarzowa
// Low-caliber crew SMG round

/obj/projectile/bullet/c27_54cesarzowa
	name = ".27-54 Cesarzowa piercing bullet"
	damage = 15
	armour_penetration = 30
	wound_bonus = -10

/obj/projectile/bullet/c27_54cesarzowa/rubber
	name = ".27-54 Cesarzowa rubber bullet"
	stamina = 15
	damage = 6
	wound_bonus = -30
	bare_wound_bonus = -10

// 5.7x39, goes in the nukie P90
/obj/projectile/bullet/c57x39mm
	name = "5.7x39mm bullet"
	damage = 20
	speed = BULLET_SPEED_PDW
	armour_penetration = 10

/obj/projectile/bullet/c57x39mm/hp
	name = "5.7x39mm hollow point bullet"
	damage = 30
	armour_penetration = -10
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c57x39mm/ap
	name = "5.7x39mm armor piercing bullet"
	damage = 19
	armour_penetration = 30
	speed_mod = BULLET_SPEED_AP_MOD
