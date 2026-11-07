
// 7.62 (Nagant Rifle)

/obj/projectile/bullet/a762
	name = "7.62x54R bullet"
	damage = 37
	armour_penetration = 30
	speed = BULLET_SPEED_RIFLE

/obj/projectile/bullet/a762/surplus
	name = "7.62x54R surplus bullet"
	armour_penetration = 10 //this is specifically more important for fighting carbons than fighting noncarbons. Against a simple mob, this is still a full force bullet
	armour_ignorance = 0
	speed_mod = BULLET_SPEED_SURPLUS_MOD

/obj/projectile/bullet/a762/match
	name = "7.62x54R match bullet"
	damage = 40
	armour_penetration = 27
	speed_mod = BULLET_SPEED_AP_MOD
	ricochets_max = 4
	ricochet_chance = 80
	ricochet_auto_aim_angle = 40
	ricochet_auto_aim_range = 5
	ricochet_incidence_leeway = 50
	ricochet_decay_chance = 1
	ricochet_decay_damage = 1

/obj/projectile/bullet/a762
	name = "8x50mmR hollow point bullet"
	damage = 50
	armour_penetration = 10
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/a762/enchanted
	name = "enchanted 7.62x54R bullet"
	damage = 20
	stamina = 40


// 5.56mm (M-90gl Carbine)

/obj/projectile/bullet/a556
	name = "5.56mm bullet"
	damage = 25
	armour_penetration = 20
	wound_bonus = -40

/obj/projectile/bullet/a556/hp
	name = "5.56mm hollow point bullet"
	damage = 35
	armour_penetration = -20

/obj/projectile/bullet/a556/ap
	name = "5.56mm armor piercing bullet"
	damage = 22
	armour_penetration = 40

/obj/projectile/bullet/a556/weak //centcom
	damage = 20

/obj/projectile/bullet/a556/phasic
	name = "5.56mm phasic bullet"
	icon_state = "gaussphase"
	damage = 20
	armour_penetration = 80
	projectile_phasing =  PASSTABLE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSDOORS

// .40 Sol Long, caseless rifle bullets

/obj/projectile/bullet/c40sol
	name = ".40 Sol Long bullet"
	damage = 20
	wound_bonus = -10
	bare_wound_bonus = 5

/obj/projectile/bullet/c40sol/fragmentation
	name = ".40 Sol Long fragmentation bullet"
	damage = 10
	stamina = 15
	weak_against_armour = TRUE
	sharpness = SHARP_EDGED
	wound_bonus = -5
	bare_wound_bonus = 10
	shrapnel_type = /obj/item/shrapnel/stingball
	embed_type = /datum/embedding/c40sol
	embed_falloff_tile = -5

/datum/embedding/c40sol
	embed_chance = 50
	fall_chance = 5
	jostle_chance = 5
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 2
	jostle_pain_mult = 3
	rip_time = 0.5 SECONDS

/obj/projectile/bullet/c40sol/pierce
	name = ".40 Sol match bullet"
	icon_state = "gaussphase"
	speed = 1.4
	damage = 15
	armour_penetration = 40
	wound_bonus = -30
	bare_wound_bonus = -10
	ricochets_max = 2
	ricochet_chance = 80
	ricochet_auto_aim_range = 4
	ricochet_incidence_leeway = 65
	projectile_piercing = PASSMOB

/obj/projectile/bullet/c40sol/pierce/on_hit(atom/target, blocked = 0, pierce_hit)
	if(isliving(target))
		var/mob/living/poor_sap = target

		// If the target mob has enough armor to stop the bullet, or the bullet has already gone through two people, stop it on this hit
		if((poor_sap.run_armor_check(def_zone, BULLET, "", "", silent = TRUE) > 20) || (pierces > 2))
			projectile_piercing = NONE

			if(damage > 10) // Lets just be safe with this one
				damage -= 5
			armour_penetration -= 10

	return ..()


/obj/projectile/bullet/c40sol/incendiary
	name = ".40 Sol Long incendiary bullet"
	icon_state = "redtrac"
	damage = 15
	/// How many firestacks the bullet should impart upon a target when impacting
	var/firestacks_to_give = 1

/obj/projectile/bullet/c40sol/incendiary/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()

	if(iscarbon(target))
		var/mob/living/carbon/gaslighter = target
		gaslighter.adjust_fire_stacks(firestacks_to_give)
		gaslighter.ignite_mob()
