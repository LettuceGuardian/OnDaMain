//.22lr (Low power spam round)

/obj/projectile/bullet/c22lr
	name = ".22LR bullet"
	damage = 20
	armour_penetration = -40
	ricochet_incidence_leeway = 20
	ricochet_chance = 65
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c22lr/surplus
	name = ".22LR surplus bullet"

/obj/projectile/bullet/c22lr/hp
	name = ".22LR HP bullet"
	damage = 24
	armour_penetration = -50
	ricochet_chance = 0
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c22lr/ap
	name = ".22LR armor piercing bullet"
	damage = 18
	armour_penetration = -20
	ricochet_incidence_leeway = 20
	ricochet_chance = 30
	speed_mod = BULLET_SPEED_AP_MOD

// 9mm (Makarov and Stechkin APS)

/obj/projectile/bullet/c9mm
	name = "9mm bullet"
	damage = 20
	armour_penetration = -20
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c9mm/ap
	name = "9mm armor-piercing bullet"
	damage = 18
	armour_penetration = 10
	speed = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c9mm/hp
	name = "9mm hollow point bullet"
	damage = 30
	armour_penetration = -30
	speed = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/incendiary/c9mm
	name = "9mm incendiary bullet"
	damage = 15
	fire_stacks = 2
	armour_penetration = -30

// 10mm

/obj/projectile/bullet/c10mm
	name = "10mm bullet"
	damage = 25
	armour_penetration = -20
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c10mm/ap
	name = "10mm armor-piercing bullet"
	damage = 25
	armour_penetration = 10
	speed = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c10mm/hp
	name = "10mm hollow point bullet"
	damage = 35
	armour_penetration = -30
	speed = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/incendiary/c10mm
	name = "10mm incendiary bullet"
	damage = 20
	fire_stacks = 3

// .45 (M1911 & C20r)

/obj/projectile/bullet/c45
	name = ".45 bullet"
	damage = 25
	armour_penetration = -20
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c45/ap
	name = ".45 armor-piercing bullet"
	damage = 22
	armour_penetration = 10
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c45/hp
	name = ".45 hollow-point bullet"
	damage = 37
	armour_penetration = -30
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/incendiary/c45
	name = ".45 incendiary bullet"
	damage = 15
	fire_stacks = 2

/obj/projectile/bullet/c45/rubber
	name = ".45 rubber bullet"
	damage = 7
	stamina = 37
	armour_penetration = -30
	speed_mod = BULLET_SPEED_RUBBER_MOD
	ricochet_chance = 130
	ricochet_decay_damage = 1
	shrapnel_type = null
	sharpness = NONE
	embed_type = null

/obj/projectile/bullet/c45/caseless
	damage = 26 //parent damage var is 30

// .50AE (Desert Eagle)

/obj/projectile/bullet/a50ae
	name = ".50AE bullet"
	damage = 60
	speed_mod = BULLET_SPEED_HP_MOD

///.35 sol short, weak crew pistol/smg round

/obj/projectile/bullet/c35sol ///Yes yes, fits in both pistols and revolvers. I'm putting it here
	name = ".35 Sol Short bullet"
	damage = 15
	wound_bonus = -5 // Normal bullets are 20
	bare_wound_bonus = 5
	embed_falloff_tile = -4

/obj/projectile/bullet/c35sol/incapacitator // .35 Sol's equivalent to a rubber bullet
	name = ".35 Sol Short incapacitator bullet"
	damage = 5
	stamina = 15
	wound_bonus = -40
	bare_wound_bonus = -20
	weak_against_armour = TRUE

	// The stats of the ricochet are a nerfed version of detective revolver rubber ammo
	// This is due to the fact that there's a lot more rounds fired quickly from weapons that use this, over a revolver
	ricochet_auto_aim_angle = 30
	ricochet_auto_aim_range = 5
	ricochets_max = 4
	ricochet_incidence_leeway = 50
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = null
	sharpness = NONE
	embed_type = null

/obj/projectile/bullet/c35sol/ripper // .35 Sol ripper, similar to the detective revolver's dumdum rounds, causes slash wounds and is weak to armor
	name = ".35 Sol ripper bullet"
	damage = 12
	weak_against_armour = TRUE
	sharpness = SHARP_EDGED
	wound_bonus = 20
	bare_wound_bonus = 20
	embed_type = /datum/embedding/c35sol
	embed_falloff_tile = -15

/datum/embedding/c35sol
	embed_chance = 75
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 6
	rip_time = 1 SECONDS

/obj/projectile/bullet/c35sol/pierce // What it says on the tin, AP rounds
	name = ".35 Sol Short armor piercing bullet"
	damage = 13
	bare_wound_bonus = -30
	armour_penetration = 30


///.35 Auto, sec standard carry round

/obj/projectile/bullet/c35
	name = ".35 Auto bullet"
	damage = 20
	wound_bonus = -5

/obj/projectile/bullet/c35/rubber
	name = ".35 Auto rubber bullet"
	icon = 'monkestation/code/modules/security/icons/paco_ammo.dmi'
	icon_state = "rubber_bullet"
	damage = 4
	stamina = 24
	sharpness = NONE
	embed_type = null
