
[core]
name: ${name}
displayText: ${displayName}
displayText_ru: ${displayName_ru}
displayDescription: ${description1}\n ${description2}
displayDescription_ru: ${description1_ru}\n${description2_ru}
#showInEditor: false

class: CustomUnitMetadata
maxHp: 2500
mass: 3000
price: 0
isBuilding: false
techLevel: 1
buildSpeed: 0s
#availableInDemo: true
canNotBeDirectlyAttacked: true
radius: 40
isBio: false
createNeutral: true
stayNeutral: true
tags: item, module, gun, ${name}, tier${tier}
disableAllUnitCollisions: true
transportSlotsNeeded: 3
isUnselectable: true
energyMax: ${tier * 150}
@memory weaponRange:number
@memory weight:number
@memory tier:number
@memory isSentryCompatible: bool
fogOfWarSightRange: 0

[hiddenAction_takeRange]
autoTriggerOnEvent: created
setUnitMemory: weaponRange=${atkRange}, weight=${weight}, tier=${tier}

[hiddenAction_setTarget]
autoTrigger: if parent.parent.attacking != null and self.attacking != parent.parent.attacking
addWaypoint_type: attack
clearActiveWaypoint: true
addWaypoint_target_fromReference: unitref parent.parent.attacking

[hiddenAction_kill]
autoTriggerOnEvent: killedAnyUnit
requireConditional: if eventSource.tags(includes="tracked") or eventSource.tags(includes="walker")
showMessageToAllPlayers: %{self.playerName()} killed %{eventSource.playerName()} using ${displayName}



[hiddenAction_noenemy]
autoTrigger: if distanceBetween(self, attacking) > ${atkRange}
clearActiveWaypoint: true
clearAllWaypoints: true

[hiddenAction_lightWp]
autoTrigger: if (self.tags(includes="tier1") or self.tags(includes="tier2") or self.tags(includes="tier3")) and not self.tags(includes="sentryCompatible")
temporarilyAddTags: sentryCompatible
setUnitMemory: isSentryCompatible = true

[hiddenAction_removeTagOnInv]
autoTrigger: if self.hasParent() and self.tags(includes="gun")
temporarilyRemoveTags: item, gun, module, tier${tier}

[hiddenAction_removeTagOnInvS]
autoTrigger: if self.hasParent() and self.tags(includes="sentryCompatible") and memory.isSentryCompatible == true
temporarilyRemoveTags: sentryCompatible

[hiddenAction_returnTagOutsideInv]
autoTrigger: if not self.hasParent() and not self.tags(includes="gun")
temporarilyAddTags: item, gun, module, tier${tier}

[hiddenAction_retyrnTagOutsideInvS]
autoTrigger: if not self.hasParent() and not self.tags(includes="sentryCompatible") and memory.isSentryCompatible == true
temporarilyAddTags: sentryCompatible

[hiddenAction_deleteWhenNoParentAndFromSpawner]
autoTrigger: if not self.hasParent() and customTarget1.tags(includes="weaponSpawner") and self.timeAlive() > 120
deleteSelf: true
debugMessage: ${name} deleted

[hiddenAction_thereArePlayers]
autoTrigger: if nearestUnit(withTag="player", relation="any", withinRange=100) != null
switchToTeam: nearestUnit(withTag="player", relation="any", withinRange=100).teamId()

[hiddenAction_autoNeutral]
switchToNeutralTeam: true
autoTrigger: if numberOfUnitsInTeam(withTag="player", lessThan=1, withinRange=120)
#addResources: unsetFlag=0

[graphics]
total_frames: 3

image: ${image}
image_wreak:NONE
image_turret: NONE
animation_attack_start: 0
animation_attack_end: 2
animation_attack_speed: 2

[attack]
canAttack: true
canAttackFlyingUnits: true
canAttackLandUnits:   true
canAttackUnderwaterUnits: false
turretTurnSpeed: ${turretTurnSpeed}
maxAttackRange: ${atkRange}
aimOffsetSpread: 0
isFixedFiring:true

[turret_main]
delay: ${atkDelay}
#miniRifle, machineGun, rocketLauncher, voltaicSlug, laser, arsonSlug
x: 0
y: 0
size: ${turret_size}
canAttackCondition: if self.hasParent() and (parent.parent.resource.statusJam < 1) and (parent.parent.resource.statusStun < 1)

[template_miniRifle]
x: 0
y: 0
projectile: miniRifle
shoot_sound: ../audio/sentry_shoot.wav
shoot_sound_vol: 0.35
shoot_flame: small
resourceUsage: charge=1

[projectile_miniRifle]
tags: proj
directDamage: 20
turnSpeed: 0
life: 300
image: ../projectiles/p_ATRifle.png
deflectionPower: 1


[template_pulsar]
x: 0
y: 0
projectile: pulsar
shoot_sound: ../audio/pulsar.ogg
shoot_sound_vol: 0.35
shoot_flame: CUSTOM:cyanPlasma
resourceUsage: charge=2

[projectile_pulsar]
tags: proj
directDamage: 10
turnSpeed: 0
life: 300
speed: 3
drawSize: 0.75
image: ../projectiles/p_pulsar.png
deflectionPower: 2
explodeEffect: CUSTOM:cyanPlasma
trailEffect: CUSTOM:projectileTrail

[effect_cyanPlasma]
attachedToUnit: false
life: 30
image: ../misc/pulsarBoom.png
priority: verylow
total_frames: 9
animateFrameStart: 0
animateFrameEnd: 8
animateFramePingPong: false
animateFrameSpeed: 0.25
scaleFrom: 1
scaleTo: 1.2

[template_machineGun]
x: 0
y: 0
projectile: machineGun
shoot_sound: ../audio/mg.wav
shoot_sound_vol: 0.35
shoot_flame: small
resourceUsage: charge=3


[projectile_machineGun]
tags: proj
directDamage: 50
life: 300
turnSpeed: 0
image: ../projectiles/p_machineGun.png
speed: 5
explodeEffect: CUSTOM:shells*5
deflectionPower: 3

[template_minigun]
x: 0
y: 0
projectile: minigun
shoot_sound: ../audio/minigun.ogg
shoot_sound_vol: 0.5
shoot_flame: small
resourceUsage: charge=5


[projectile_minigun]
tags: proj
directDamage: 70
life: 300
turnSpeed: 0
image: ../projectiles/p_machineGun.png
speed: 7
explodeEffect: CUSTOM:shells*5
deflectionPower: 5
pushForce: 1
pushVelocity: 1


[template_sniper]
x: 0
y: 0
projectile: sniper
shoot_sound: ../audio/sniper.ogg
shoot_sound_vol: 0.75
shoot_flame: small
resourceUsage: charge=15


[projectile_sniper]
tags: proj
directDamage: 400
life: 300
turnSpeed: 0
image: ../projectiles/p_machineGun.png
speed: 15
explodeEffect: CUSTOM:shells*20
deflectionPower: 20
trailEffect: CUSTOM:sTrail
trailEffectRate: 1

[effect_shells]
attachedToUnit: false
life: 100
physics: true
xSpeedRelativeRandom: 1.6
ySpeedRelativeRandom: 1.6
hSpeed: 2
image: ../misc/bit.png
priority: verylow


[template_rocketLauncher]
x: 0
y: 0
projectile: rocketLauncher
shoot_sound: missile_fire
shoot_sound_vol: 0.75
resourceUsage: charge=25

[projectile_rocketLauncher]
tags: proj
life: 240
speed: 0.3
targetSpeed: 6
trailEffect: true
largeHitEffect: true
image: ../projectiles/p_rocketLauncher.png
drawSize: 0.75
areaDamage: 300
areaRadius: 100
explodeEffect: CUSTOM:piece*20
deflectionPower: 30


[effect_piece]
attachedToUnit: false
life: 100
physics: true
atmospheric: true
xSpeedRelativeRandom: 3
ySpeedRelativeRandom: 3
hSpeed: 2
image: ../misc/bit3.png
priority: verylow

#=================================


[template_celebration]
x: 0
y: 0
projectile: celebration
shoot_sound: ../audio/celebration.wav
shoot_sound_vol: 0.75
resourceUsage: charge=25

[projectile_celebration]
tags: proj
life: 999999
speed: 0.3
targetSpeed: 2
trailEffect: true
largeHitEffect: true
image: ../projectiles/p_celebration.png
drawSize: 0.75
areaDamage: 200
areaRadius: 55
deflectionPower: 30

[template_laser]
x: 0
y: 0
projectile:laser
shoot_sound: plasma_fire
shoot_sound_vol: 0.75
resourceUsage: charge=50
chargeEffectImage: ../misc/chargeRed.png
warmup: 2.5s

[projectile_laser]
directDamage: 500
life: 10
largeHitEffect: true
instant:true
laserEffect:true
instantReuseLast:true
color:#6fff0000
explodeEffect: CUSTOM:laserspark*10
deflectionPower: -1

[effect_laserspark]
attachedToUnit: false
life: 100
physics: true
atmospheric: true
xSpeedRelativeRandom: 3
ySpeedRelativeRandom: 3
hSpeed: 2
image: ../misc/bit2.png
priority: verylow

[template_boson]
x: 0
y: 0
projectile:boson
shoot_sound: ../audio/boson.ogg
shoot_sound_vol: 0.75
resourceUsage: charge=10

[projectile_boson]
#Critical!
life: 15
instant:true
instantReuseLast: true
instantReuseLast_alsoChangeTurretAim: true
moveWithParent: true
beamImage:     ../projectiles/bosonBeam.png
beamImageEnd:   ../projectiles/bosonBeamEnds.png
beamImageStart: ../projectiles/bosonBeamEnds.png
beamImageOffsetRate: 3
explodeEffect: NONE
explodeEffectOnShield: NONE
shieldDamageMultiplier: 0.75
sweepOffsetFromTargetRadius:0.4
sweepSpeed:20
#damage
directDamage: 5
mutator1_ifUnitWithTags: rover
mutator1_addResourcesDirectHit: statusSlowed=5

[template_laser2]
x: 0
y: 0
projectile: laser2
shoot_sound: ../audio/boom.wav
shoot_sound_vol: 0.75
resourceUsage: charge=25

[projectile_laser2]
#Critical!
life: 50
instant:true
instantReuseLast: true
instantReuseLast_alsoChangeTurretAim: true
moveWithParent: true
beamImage:     ../projectiles/p_laserr.png
beamImageEnd:   ../projectiles/p_laser2_end.png
beamImageEndRotated: true
beamImageStart: ../projectiles/p_laser2.png
beamImageStartRotated: true
beamImageOffsetRate: 1
explodeEffect: NONE
explodeEffectOnShield: NONE
#shieldDamageMultiplier: 0.75
sweepOffsetFromTargetRadius:0.4
sweepSpeed:20
#damage
directDamage: 750
explodeEffect: CUSTOM:laserspark*10

[template_voltaicSlug]
x: 0
y: 0
projectile: voltaicSlug
shoot_sound: ../audio/vs.wav
shoot_sound_vol: 0.75
resourceUsage: charge=20

[projectile_voltaicSlug]
areaDamage: 100
areaRadius: 30
turnSpeed: 0
life: 500
image: ../projectiles/p_voltaicSlug.png
shieldDamageMultiplier: 5
shieldDefectionMultiplier: 2
buildingDamageMultiplier: 0.5
explodeEffect:CUSTOM:lightningShock, CUSTOM:sparks*20
explodeEffectOnShield:CUSTOM:lightningShock*1, CUSTOM:hitLightFlash, CUSTOM:sparkss*30
trailEffect: CUSTOM:projectileTrail
deflectionPower: 35
mutator1_ifUnitWithTags: rover
mutator1_addResourcesAreaHit: statusStun=2

[effect_sparkss]
attachedToUnit: false
life: 50
physics: true
atmospheric: true
xSpeedRelativeRandom: 3
ySpeedRelativeRandom: 3
hSpeed: 2
image: ../misc/bit4.png
priority: critical

[effect_hitLightFlash]
priority:high
image: SHARED:light_50.png
life: 17
fadeOut: true
attachedToUnit: false
color: #63e6e8
scaleFrom: 1.8
scaleTo: 1.8
alpha: 0.6
drawUnderUnits:false


[effect_lightningShock]
life: 1000
hOffset: 0
dirOffset: 0
fadeInTime: 0
fadeOut: false
attachedToUnit: true
image: SHARED:lightning_shock.png
total_frames: 14
animateFrameStart: 0
animateFrameEnd: 13
animateFramePingPong: false
animateFrameSpeed: 0.5

[effect_sparks]
attachedToUnit: false
life: 150
physics: true
xSpeedRelativeRandom: 1.6
ySpeedRelativeRandom: 1.6
hSpeed: 2
image: SHARED:spark.png
priority: verylow

[effect_sparks2]
attachedToUnit: false
life: 150
physics: true
xSpeedRelativeRandom: 0.5
ySpeedRelativeRandom: 0.5
hSpeed: 1
image: SHARED:spark.png
priority: verylow

[effect_projectileTrail]
image: SHARED:light_50.png
life: 35
fadeOut: true
attachedToUnit: false
color: #63e6e8
fadeInTime:2
scaleFrom: 0.75
scaleTo: 0.55
alpha: 0.6
drawUnderUnits:true

[template_arsonSlug]
x: 0
y: 0
projectile: arsonSlug
shoot_sound: ../audio/vs.wav
shoot_sound_vol: 0.75
resourceUsage: charge=30

[projectile_arsonSlug]
areaDamage: 75
areaRadius: 20
drawSize: 0.5
speed: 1.5
turnSpeed: 0
life: 500
image: ../projectiles/p_arsonCannon.png
buildingDamageMultiplier: 0.5
flameWeapon: true
trailEffect: CUSTOM:vTrail
spawnUnit: fireFX1m(spawnChance=0.25)
deflectionPower: 40

[effect_vTrail]
image: ../misc/vapor.png
life: 350
fadeOut: true
attachedToUnit: false
color: #FFFFFF
fadeInTime:5
scaleFrom: 0.5
scaleTo: 1
alpha: 0.6
drawUnderUnits:false
#ySpeedRelative:-1
atmospheric:true
dirOffsetRandom:180
xSpeedAbsoluteRandom: 0.05
ySpeedAbsoluteRandom: 0.05


[template_mineLauncher]
x: 0
y: 0
projectile: mineLauncher
shoot_sound: ../audio/vs.wav
shoot_sound_vol: 0.75
resourceUsage: charge=40

[projectile_mineLauncher]
areaDamage: 0
areaRadius: 0
targetGround: true
life: 500
image: ../projectiles/p_nanoMine.png
deflectionPower: -1
spawnUnit: nanomine*5(offsetRandomX=30, offsetRandomY=30)
gravity: 1
initialUnguidedSpeedHeight: 2

[template_baros]
x: 0
y: 0
projectile: baros
shoot_sound: ../audio/baros.ogg
shoot_sound_vol: 0.75
resourceUsage: charge=50
shoot_flame: CUSTOM:barosFresh

[projectile_baros]
areaDamage: 350
areaRadius: 200
targetGround: true
targetGroundSpread: 5
drawSize: 1.25
speed: 3
turnSpeed: 0
life: 500
image: ../projectiles/p_baros.png
buildingDamageMultiplier: 2
trailEffect: CUSTOM:barosTrail
deflectionPower: 60
explodeEffect: CUSTOM:barosHit
gravity: 1
initialUnguidedSpeedHeight: 2
mutator1_ifUnitWithTags: rover
mutator1_addResourcesAreaHit: statusSlowed=10
pushForce: 2
pushVelocity: -0.5

[effect_barosTrail]
image: ../projectiles/p_barosTail.png
life: 400
fadeOut: true

attachedToUnit: false
color: #FFFFFF
fadeInTime:5
scaleFrom: 1.3
scaleTo: 0.2
alpha: 0.6
drawUnderUnits:false
#ySpeedRelative:-1
atmospheric:true

[effect_barosHit]
attachedToUnit: false
life: 50
scaleFrom: 0.5
scaleTo: 5
image: ../misc/baros_hit.png
priority: high
dirOffsetRandom: 360
alsoPlaySound: ../audio/barosHit.ogg

[effect_barosFresh]
attachedToUnit: false
life: 100
scaleFrom: 0.2
scaleTo: 3
image: ../misc/baros_hit.png
priority: high
dirOffsetRandom: 360

[template_sonic]
x: 0
y: 0
projectile: sonic
shoot_sound: ../audio/sonicboom.ogg
shoot_sound_vol: 0.75
resourceUsage: charge=75

[projectile_sonic]
areaDamage: 150
areaRadius: 20
drawSize: 0.8
turnSpeed: 0
speed: 10
life: 500
#image: ../projectiles/p_sonic.png
image: null.png
trailEffect: CUSTOM:sTrail
trailEffectRate: 0.01
deflectionPower: -1
mutator1_ifUnitWithTags: rover
mutator1_addResourcesAreaHit: statusStun=5


[effect_sTrail]
image: ../projectiles/p_sonic.png
life: 40
fadeOut: true
attachedToUnit: false
color: #FFFFFF
#fadeInTime:5
scaleFrom: 0.5
scaleTo: 0.8
alpha: 0.2
drawUnderUnits:false
#ySpeedRelative:-1
#atmospheric:true
#dirOffsetRandom:180
#xSpeedAbsoluteRandom: 0.05
#ySpeedAbsoluteRandom: 0.05

[template_monolith]
x: 0
y: 0
projectile: monolith
shoot_sound: ../audio/monolith.ogg
shoot_sound_vol: 0.75
shoot_flame: small
resourceUsage: charge=100

[projectile_monolith]
tags: proj
directDamage: 600
life: 300
turnSpeed: 0
image: ../projectiles/p_monolith.png
speed: 20
deflectionPower: 200
trailEffect: CUSTOM:sTrailCyan
trailEffectRate: 0.00001

[effect_sTrailCyan]
image: ../projectiles/p_sonic2.png
life: 200
fadeOut: true

attachedToUnit: false
color: #00cbFF
#fadeInTime:5
scaleFrom: 0.8
scaleTo: 1
drawUnderUnits:false

[movement]
movementType: LAND
moveSpeed: 0
moveAccelerationSpeed: 1
moveDecelerationSpeed: 1
targetHeight: 10
maxTurnSpeed: ${turretTurnSpeed}
turnAcceleration: 1
